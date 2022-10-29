module SignUp
  class AssignRoleAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user

      user.add_role user.sign_up_role unless user.has_role?(user.sign_up_role)
    end
  end
end
