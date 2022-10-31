module Users
  class SendPasswordResetEmailAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user

      UserMailer.with(user:).password_reset_email.deliver_later

      user.password_reset_token_sent!
    end
  end
end
