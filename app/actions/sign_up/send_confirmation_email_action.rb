module SignUp
  class SendConfirmationEmailAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user

      next if user.skip_confirmation?

      UserMailer.with(user: user).confirmation_email.deliver_later

      user.confirmation_token_sent!
    end
  end
end
