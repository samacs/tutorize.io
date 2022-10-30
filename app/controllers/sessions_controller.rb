class SessionsController < FrontendController
  before_action :require_no_user, only: %i[new create]
  before_action :require_user, only: :destroy

  before_action :set_user, only: :create

  # decorates_assigned :user

  add_body_classes 'sign-in'

  def new
    @user = User.new
  end

  def create
    # TODO: Check if user is resetting password
    return render :new, status: :unauthorized if user_not_found_error? ||
                                                 confirmation_error? ||
                                                 wrong_password_error?

    sign_in!(@user)

    redirect_back_or_default authenticated_root_path
  end

  def destroy
    sign_out!

    redirect_to root_path
  end

  private

  def user_not_found_error?
    return false if @user.present?

    flash.now[:error] = t('.credentials_error')

    true
  end

  def confirmation_error?
    return false if @user.confirmed?

    flash.now[:errors] = t('.confirmation_error')

    true
  end

  def wrong_password_error?
    return false if @user.authenticate(session_params[:password])

    flash.now[:error] = t('.credentials_error')

    true
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by(email: session_params[:email])
  end
end
