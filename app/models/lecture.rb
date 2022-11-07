class Lecture < ApplicationRecord
  extend FriendlyId

  include Tokenizable

  DATES_SERIES = <<~SQL.squish
    SELECT date_trunc('day', series)::date AS date
    FROM generate_series('%<from_date>s'::timestamp, '%<to_date>s'::timestamp, '1 day'::interval) AS series
  SQL
  DATE_SERIES_JOIN = <<~SQL.squish
    INNER JOIN date_series
      ON (date_series.date = date_trunc('day', lectures.starts_at))
  SQL
  DATE_SERIES_SELECT = <<~SQL.squish
    date_series.date AS date_group,
    numrange(
      (extract(hours from lectures.starts_at) + (extract(minutes from lectures.starts_at) / 60.00)),
      (extract(hours from lectures.ends_at) + (extract(minutes from lectures.ends_at) / 60.00))
    ) AS time_slot,
    count(enrollments.id) AS enrollments_count,
    lectures.*
  SQL

  friendly_id :slug

  belongs_to :lesson

  has_one :course, through: :lesson
  has_one :teacher, through: :lesson

  has_many :enrollments, dependent: :destroy, inverse_of: :lecture

  scope :upcoming, -> { where('starts_at > ?', Time.current) }
  scope :past, -> { where('starts_at < ?', Time.current) }
  scope :with_date_series, lambda { |from_date, to_date|
    with(date_series: format(DATES_SERIES, from_date:, to_date:))
      .joins(:enrollments)
      .joins(DATE_SERIES_JOIN)
      .select(DATE_SERIES_SELECT)
      .reorder('date_series.date ASC')
      .group(:date_group, :time_slot, :id)
      .group_by { |lecture| [lecture.date_group, lecture.time_slot] }
  }

  validates :starts_at,
            :ends_at,
            presence: true

  validate :validate_lecture_duration
  validate :validate_start_and_end_times

  before_validation -> { generate_token(:slug) if slug.blank? }

  def started?
    started_at.present?
  end

  def ended?
    ended_at.present?
  end

  def can_be_started?
    lower_threshold = starts_at - Setting.start_end_minutes_lower_threshold
    upper_threshold = starts_at + Setting.start_end_minutes_upper_threshold
    !started? && !ended? && Time.current.between?(lower_threshold, upper_threshold)
  end

  def can_be_ended?
    lower_threshold = ends_at - Setting.start_end_minutes_lower_threshold
    upper_threshold = ends_at + Setting.start_end_minutes_upper_threshold
    started? && !ended? && Time.current.between?(lower_threshold, upper_threshold)
  end

  private

  def validate_start_and_end_times
    errors.add(:starts_at, "must be before than end time: #{ends_at}") if starts_at.after?(ends_at)
    errors.add(:ends_at, "must be after than start time: #{starts_at}") if ends_at.before?(starts_at)
  end

  def validate_lecture_duration
    return if fits_duration?

    errors.add(:ends_at,
               "must be #{lesson.duration} hours (#{starts_at + lesson.duration.hours}) after start time #{starts_at}")
  end

  def fits_duration?
    (ends_at - starts_at) != lesson.duration
  end
end
