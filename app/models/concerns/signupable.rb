module Signupable
  extend ActiveSupport::Concern

  SIGN_UP_ROLES = [User::TEACHER_ROLE, User::STUDENT_ROLE].freeze

  included do
    attr_writer :sign_up_role

    validates :sign_up_role,
              inclusion: { in: SIGN_UP_ROLES }

    after_create :sign_up!

    after_commit :assign_sign_up_role!, on: :create
  end

  def sign_up_role
    @sign_up_role ||= roles.order(created_at: :desc).where(name: %i[teacher student]).first&.name
  end

  private

  def assign_sign_up_role!
    add_role sign_up_role unless has_role?(sign_up_role)
  end

  def sign_up!
    SignUpWorker.perform_async(id)
  end
end
