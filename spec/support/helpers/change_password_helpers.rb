module ChangePasswordHelper
  def change_password(options)
    user = options.fetch(:user, nil)
    email = options.fetch(:email, user&.email)
    password_reset_token = options.fetch(:password_reset_token, user&.password_reset_token)
    visit change_password_path(email:, password_reset_token:) if email.present? && password_reset_token.present?

    password = options.fetch(:password, nil)
    password_confirmation = options.fetch(:password_confirmation, nil)

    fill_in_change_password_form(password:, password_confirmation:, submit: true)
  end

  def fill_in_change_password_form(submit: false, **options)
    fields = %i[password password_confirmation]
    attributes = options.slice(*fields).stringify_keys
    I18n.with_options(scope: 'activerecord.attributes.user') do |i18n|
      attributes.each { |field, value| fill_in i18n.t(field), with: value }
    end

    click_button t('password_resets.edit.button.submit') if submit
  end
end

RSpec.configure do |config|
  config.include ChangePasswordHelper
end
