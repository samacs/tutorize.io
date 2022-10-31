module Users
  class CreateAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user
      next if user.persisted?

      ctx.fail_and_return! user.errors unless user.save
    end
  end
end
