class Availability < ApplicationRecord
  include TimeHelpers

  WEEKDAY_AND_DATES_SERIES = <<~SQL.squish
    SELECT extract(dow FROM series) AS weekday, date_trunc('day', series)::date AS date FROM generate_series('%<from_date>s'::timestamp, '%<to_date>s'::timestamp, '1 day'::interval) AS series
  SQL
  DATE_SERIES_JOIN = <<~SQL.squish
    INNER JOIN date_series ON (date_series.date = availabilities.date OR date_series.weekday = availabilities.weekday)
  SQL

  belongs_to :teacher, class_name: 'User', inverse_of: :availabilities

  scope :for_weekday, ->(weekday) { where(weekday:) }
  scope :for_date, ->(date) { where(date: date) }
  scope :available, -> { where(available: true) }
  scope :not_available, -> { where(available: false) }
  scope :weekdays, -> { order(:weekday).where(weekday: 0..6) }
  scope :with_weekday_and_dates_series, lambda { |from_date, to_date|
    with(date_series: format(WEEKDAY_AND_DATES_SERIES, from_date:, to_date:))
      .joins(DATE_SERIES_JOIN)
      .select('date_series.date AS date_group, availabilities.*')
      .reorder('date_series.date ASC')
      .group_by(&:date_group)
  }

  validates :from, numericality: { less_than_or_equal_to: :to }
  validates :to, numericality: { greater_than_or_equal_to: :from }

  validate :validate_date_or_weekday
  validate :validate_overlapping

  class << self
    def available_time_slots(from_date, to_date)
      intervals = {}
      with_weekday_and_dates_series(from_date, to_date).each do |date, availabilities|
        intervals[date] ||= IntervalSet.new
        availabilities.each do |availability|
          range = (availability.from..availability.to)
          intervals[date] << range if availability.available?
          intervals[date] >> range if availability.not_available?
        end
      end
      intervals
    end
  end

  def from=(value)
    value = calculate_from_string(value) if value.is_a?(String)

    super
  end

  def to=(value)
    value = calculate_from_string(value) if value.is_a?(String)

    super
  end

  def from_time
    @from_time ||= time_from_decimal(from)
  end

  def to_time
    @to_time ||= time_from_decimal(to)
  end

  def calculate_from_string(value)
    value = Time.zone.parse(value)
    value.to_time.hour + (value.to_time.min / 60.00)
  end

  def not_available?
    !available?
  end

  def unavailable?
    !available?
  end

  private

  def validate_date_or_weekday
    errors.add(:date, 'or week day must be selected') if date.nil? && weekday.nil?
  end

  def validate_overlapping
    validate_weekday_overlapping if weekday.present?
    validate_date_overlapping if date.present?
  end

  def validate_weekday_overlapping
    query = teacher.availabilities.where.not(id:).for_weekday(weekday).where(from: [from..to], available:)
    overlapping = query.or(query.where(to: [from..to], available:)).first
    return if overlapping.blank?

    errors.add(:weekday,
               "overlaps with date from #{overlapping.from_time} to #{overlapping.to_time}")
  end

  def validate_date_overlapping
    query = teacher.availabilities.where.not(id:).for_date(date.to_date).where(from: [from..to], available:)
    overlapping = query.or(query.where(to: [from..to], available:)).first
    return if overlapping.blank?

    errors.add(:date,
               "overlaps with date from #{overlapping.from_time} to #{overlapping.to_time}")
  end
end
