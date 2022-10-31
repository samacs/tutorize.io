module RedirectionManagement
  extend ActiveSupport::Concern

  included do
    after_action :save_previous_url
  end

  protected

  def redirect_back_or_default(default = :root_url, **options)
    target_url = session.delete(:previous_url) || default
    target_url = default if target_url == request.original_url

    redirect_to target_url, options
  end

  def save_previous_url
    session[:previous_url] = if request.get?
                               request.original_url
                             else
                               request.referer
                             end
  end
end
