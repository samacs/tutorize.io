module SignInHelpers
  def sign_in(credentials)
    visit sign_in_path

    fill_in_sign_in_form(credentials, submit: true)
  end

  def fill_in_sign_in_form(credentials, submit: false)
    fields = %i[email password]
    attributes = credentials.slice(*fields).stringify_keys
    I18n.with_options(scope: 'activerecord.attributes.user') do |i18n|
      attributes.each { |field, value| fill_in i18n.t(field), with: value }
    end

    click_button t('sessions.form.button.submit') if submit
  end
end

RSpec.configure do |config|
  config.include SignInHelpers
end
