class ApplicationMailer < ActionMailer::Base
  default from: Setting.default_email_from

  layout 'mailer'

  before_action :add_mailer_views

  private

  def add_mailer_views
    prepend_view_path Rails.root.join('app/views/mailers')
  end
end
