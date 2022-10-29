module Confirm
  class ConfirmUserAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user

      ctx.fail! user.error unless user.update(confirmed_at: Time.current)
    end
  end
end
