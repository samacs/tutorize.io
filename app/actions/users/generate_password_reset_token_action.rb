module Users
  class GeneratePasswordResetTokenAction < ActionBase
    expects :user

    executed do |ctx|
      ctx.fail_and_return! unless ctx.user.generate_password_reset_token!
    end
  end
end
