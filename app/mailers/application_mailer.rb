class ApplicationMailer < ActionMailer::Base
  include ThemeManagement

  default from: Setting.default_email_from

  layout 'mailer'

  before_action :use_current_theme
end
