module SessionManagement
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :signed_in?, :teacher?, :student?, :admin?
  end

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session.key?(:user_id)
  end

  def sign_in!(user)
    user.sign_in!(request.remote_ip)

    session[:user_id] = user.id
  end

  def signed_in?
    current_user.present?
  end

  def sign_out!
    current_user.sign_out!

    reset_session
  end

  def require_user
    return if signed_in?
    # TODO: Save previous URL and redirect
  end

  def require_no_user
    return unless signed_in?

    redirect_back_or_default root_path
  end
end
