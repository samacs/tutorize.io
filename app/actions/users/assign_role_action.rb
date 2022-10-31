module Users
  class AssignRoleAction < ActionBase
    expects :user, :role_name

    executed do |ctx|
      user = ctx.user
      role_name = ctx.role_name

      user.add_role role_name unless user.has_role?(role_name)
    end
  end
end
