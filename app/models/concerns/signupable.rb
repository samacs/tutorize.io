module Signupable
  extend ActiveSupport::Concern

  SIGN_UP_ROLES = [User::TEACHER_ROLE, User::STUDENT_ROLE].freeze

  included do
    attr_writer :sign_up_role

    validates :sign_up_role,
              inclusion: { in: SIGN_UP_ROLES }

    after_create :call_sign_up_worker
  end

  def sign_up_role
    @sign_up_role ||= roles.order(created_at: :desc).where(name: %i[teacher student]).first&.name
  end

  private

  def call_sign_up_worker
    SignUpWorker.perform_async(id, sign_up_role)
  end
end
