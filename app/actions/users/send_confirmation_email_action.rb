module Users
  class SendConfirmationEmailAction < ActionBase
    expects :user
    expects :force, default: false

    executed do |ctx|
      user = ctx.user

      next if !ctx.force && (user.confirmed? || user.skip_confirmation?)

      UserMailer.with(user: user).confirmation_email.deliver_later

      user.confirmation_token_sent!
    end
  end
end
