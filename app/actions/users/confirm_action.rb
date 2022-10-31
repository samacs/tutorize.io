module Users
  class ConfirmAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user

      ctx.fail! user.errors unless user.update(confirmed_at: Time.current)
    end
  end
end
