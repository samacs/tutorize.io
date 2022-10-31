class ConfirmService < ServiceBase
  class << self
    def actions
      [Users::ConfirmAction,
       Users::SendWelcomeEmailAction]
    end
  end
end
