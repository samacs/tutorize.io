class SignUpService < ServiceBase
  class << self
    def actions
      [Users::CreateAction,
       Users::SendConfirmationEmailAction,
       Users::AssignRoleAction]
    end
  end
end
