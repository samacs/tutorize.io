class ConfirmService < ServiceBase
  class << self
    def actions
      [Confirm::ConfirmUserAction,
       Confirm::SendWelcomeEmailAction]
    end
  end
end
