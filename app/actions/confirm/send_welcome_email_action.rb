module Confirm
  class SendWelcomeEmailAction < ActionBase
    expects :user

    executed do |ctx|
      user = ctx.user
      email_name = "#{user.sign_up_role}_welcome_email".to_sym
      mailer = UserMailer.with(user:)

      mailer.send(email_name).deliver_later if mailer.respond_to?(email_name)
    end
  end
end
