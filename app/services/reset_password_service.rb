class ResetPasswordService < ServiceBase
  class << self
    def actions
      [Users::FindByEmailAction,
       Users::GeneratePasswordResetTokenAction,
       Users::SendPasswordResetEmailAction]
    end
  end
end
