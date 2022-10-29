module SignUpHelpers
  def sign_up_as_student(user_attributes)
    sign_up(user_attributes, role: 'student')
  end

  def sign_up(user_attributes, role: 'student')
    visit sign_up_path

    fill_in_sign_up_form(user_attributes, role: role, submit: true)
  end

  def fill_in_sign_up_form(user_attributes, submit: false)
    fields = %i[first_name last_name email password password_confirmation]
    attributes = user_attributes.slice(*fields).stringify_keys
    I18n.with_options(scope: 'activerecord.attributes.user') do |i18n|
      attributes.each { |field, value| fill_in i18n.t(field), with: value }
      select user_attributes[:sign_up_role], from: t('users.form.label.teacher_or_student')
    end
    find(:css, 'input[name="user[terms_of_service]"]').set(user_attributes[:terms_of_service])

    click_button t('users.form.button.submit') if submit
  end
end

RSpec.configure do |config|
  config.include SignUpHelpers
end
