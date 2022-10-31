module ResetPassword
  class FindUserByEmailAction < ActionBase
    expects :email

    promises :user

    executed do |ctx|
      email = ctx.email
      user = User.find_by(email:)

      ctx.fail_and_return! if user.blank?

      ctx.user = user
    end
  end
end
