class Enrollment < ApplicationRecord
  extend FriendlyId

  include Tokenizable

  friendly_id :slug

  belongs_to :student, class_name: 'User', inverse_of: :enrollments
  belongs_to :lecture

  has_one :teacher, through: :lecture
  has_one :lesson, through: :lecture
  has_one :course, through: :lesson

  scope :by_student, ->(student) { where(student_id: student.is_a?(User) ? student.id : student) }
  scope :by_lesson, ->(lesson) { joins(lecture: :lesson).where(lectures: { lessons: { id: lesson.id } }) }
  scope :upcoming, -> { where('scheduled_at > ?', Time.current) }
  scope :past, -> { where('scheduled_at < ?', Time.current) }

  validates :scheduled_at,
            presence: true

  before_validation -> { generate_token(:slug) if slug.blank? }
end
