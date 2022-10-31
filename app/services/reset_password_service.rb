class ResetPasswordService < ServiceBase
  class << self
    def actions
      [ResetPassword::FindUserByEmailAction,
       ResetPassword::GeneratePasswordResetTokenAction,
       ResetPassword::SendPasswordResetEmailAction]
    end
  end
end
