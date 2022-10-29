class SignUpService < ServiceBase
  class << self
    def actions
      [SignUp::CreateUserAction,
       SignUp::SendConfirmationEmailAction,
       SignUp::AssignRoleAction,
       SignUp::SendRoleEmailAction]
    end
  end
end
