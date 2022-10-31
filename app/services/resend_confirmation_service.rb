class ResendConfirmationService < ServiceBase
  class << self
    def actions
      [Users::FindByEmailAction,
       Users::SendConfirmationEmailAction]
    end
  end
end
