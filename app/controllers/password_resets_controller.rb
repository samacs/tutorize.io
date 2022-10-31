class PasswordResetsController < FrontendController
  before_action :require_no_user

  before_action :set_user, only: %i[edit update]

  add_body_classes 'reset-password'

  def new; end

  def edit
    return redirect_to reset_password_path if user_not_found_error? ||
                                              password_reset_token_expired_error?

    session[:user_resetting_password_id] = @user.id

    redirect_to change_password_path if params[:password_reset_token].present?
  end

  def create
    result = ResetPasswordService.call(email: params[:email])
    if result.success?
      redirect_to sign_in_path, success: t('.success')
    else
      flash.now[:error] = t('.error')

      render :new
    end
  end

  def update
    if @user.update(change_password_params)
      session.delete(:user_resetting_password_id)

      @user.clear_password_reset!

      redirect_to sign_in_path, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def set_user
    @user = if session.key?(:user_resetting_password_id)
              User.find_by(id: session[:user_resetting_password_id])
            else
              User.by_email(params[:email])
                  .by_password_reset_token(params[:password_reset_token])
                  .first
            end
  end

  def user_not_found_error?
    return false if @user.present?

    flash[:error] = t('.user_not_found_error')

    true
  end

  def password_reset_token_expired_error?
    return false unless @user.password_reset_token_expired?

    flash[:error] = t('.password_reset_token_expired_error')

    true
  end
end
