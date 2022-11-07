class Lesson < ApplicationRecord
  extend FriendlyId

  include CoverImageable
  include TimeHelpers

  belongs_to :course, inverse_of: :lessons
  belongs_to :teacher, class_name: 'User', inverse_of: :lessons

  has_many :lectures, dependent: :destroy, inverse_of: :lesson
  has_many :enrollments, through: :lectures
  has_many :students, through: :enrollments

  scope :newest, -> { order(created_at: :desc) }

  has_rich_text :description

  friendly_id :name

  resourcify

  validates :name,
            :description,
            presence: true
  validates :minimum_students, numericality: { less_than_or_equal_to: :maximum_students }
  validates :maximum_students, numericality: { greater_than_or_equal_to: :minimum_students }
  validates :duration, numericality: { greater_than: 0 }

  def available_time_slots(from_date, to_date)
    time_spots = {}
    lectures_by_date = lectures.with_date_series(from_date, to_date)
    teacher.available_time_slots(from_date, to_date).each do |date, availabilities|
      time_spots[date] = {}
      time_slots_by_duration = availabilities.map(&method(:convert_availabilities_for_lesson)).flatten
      intervals = IntervalSet[*time_slots_by_duration]
      intervals.each do |interval|
        lectures = lectures_by_date.fetch([date, interval], [])
        spots = maximum_students
        if lectures.any?
          lecture = lectures.first
          spots -= lecture.enrollments_count
          intervals.remove(lecture_time_slot) if lecture.enrollments_count >= maximum_students
        end
        time_spots[date][interval] = spots
      end
    end
    time_spots
  end

  # def available_time_slots(from_date, to_date)
  #   intervals = {}
  #   lectures_by_date = lectures.with_date_series(from_date, to_date)
  #   teacher.availabilities.available_time_slots(from_date, to_date).each do |date, availabilities|
  #     time_slots = availabilities.map(&method(:convert_availabilities_for_lesson)).flatten
  #     intervals[date] = IntervalSet[*time_slots]
  #     intervals[date].each do |interval|
  #       lectures = lectures_by_date.fetch([date, interval], [])
  #       next if lectures.empty?

  #       lecture = lectures.first
  #       intervals[date].remove(lecture.time_slot) if lecture.enrollments_count >= maximum_students
  #     end
  #   end
  #   intervals
  # end

  def enroll(student, start_time, end_time)
    Lecture.transaction do
      lecture = lectures.find_or_create_by(starts_at: start_time, ends_at: end_time)
      lecture.enrollments.create(student_id: student.id, scheduled_at: start_time)
    end
  end

  def enrolled?(student)
    enrollment_for_student(student).present?
  end

  def enrollment_for_student(student)
    enrollments.upcoming.by_student(student).take
  end

  private

  def convert_availabilities_for_lesson(availability)
    end_of_shift = availability.last
    availability_by_lesson = availability.step(duration).to_a
    availability_by_lesson.pop if availability_by_lesson.last > end_of_shift
    availability_by_lesson.pop if availability_by_lesson.count.odd?
    availables = []
    availability_by_lesson.each_cons(2) { |a, b| availables << (a..b) }
    availables
  end
end
