class User < ApplicationRecord
  TEACHER_ROLE      = 'teacher'.freeze
  STUDENT_ROLE      = 'student'.freeze

  include Tokenizable
  include Confirmable
  include Signupable
  include Sessionable
  include PasswordResettable
  include UserPreferences

  has_secure_password

  has_person_name

  rolify

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [120, 120]
    attachable.variant :normal, resize_to_imit: [620, 620]
    attachable.variant :list_item, resize_to_limit: [480, 480]
  end

  has_many :courses, foreign_key: :teacher_id, dependent: :destroy, inverse_of: :teacher
  has_many :lessons, foreign_key: :teacher_id, dependent: :destroy, inverse_of: :teacher
  has_many :enrolled_students, through: :lessons, source: :students
  has_many :availabilities, foreign_key: :teacher_id, dependent: :destroy, inverse_of: :teacher
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy, inverse_of: :student

  scope :by_email, ->(email) { where(email:) }
  scope :teacher, -> { with_role(:teacher) }
  scope :student, -> { with_role(:student) }

  delegate :available_time_slots,
           to: :availabilities

  validates :first_name,
            :last_name,
            :confirmation_token,
            :email,
            presence: true
  validates :email,
            uniqueness: { case_insensitive: true },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password,
            confirmation: true,
            presence: true,
            if: :changing_password?
  validates :terms_of_service,
            acceptance: { accepts: true },
            allow_nil: false,
            on: :create

  before_validation :downcase_email!

  def password=(value)
    @changing_password = true if value.present?

    super
  end

  def enrolled?(lesson)
    enrollment_for_lesson(lesson).present?
  end

  def enrollment_for_lesson(lesson)
    enrollments.upcoming.by_lesson(lesson).take
  end

  private

  def downcase_email!
    email.downcase! if email.present?
  end

  def changing_password?
    @changing_password || false
  end
end
