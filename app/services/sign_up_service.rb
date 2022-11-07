class SignUpService < ServiceBase
  class << self
    def actions
      [Users::SendConfirmationEmailAction]
    end
  end
end
