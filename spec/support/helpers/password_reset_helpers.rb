module PasswordResetHelpers
  def reset_password(email)
    visit reset_password_path

    fill_in_reset_password_form(email, submit: true)
  end

  def fill_in_reset_password_form(email, submit: false)
    fill_in t('activerecord.attributes.user.email'), with: email

    click_button t('password_resets.new.button.submit') if submit
  end
end

RSpec.configure do |config|
  config.include PasswordResetHelpers
end
