class UsersController < ApplicationController
  skip_before_action :require_user

  before_action :require_no_user

  before_action :find_user_for_confirmation, only: :confirm

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.turbo_stream
        format.html { redirect_to root_path, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    return redirect_to root_path, error: t('.error') if @user.blank?
    return redirect_to root_path, error: @user.errors.full_messages.to_sentence unless @user.confirm!

    redirect_to sign_in_path, success: t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation, :terms_of_service,
                                 :sign_up_role)
  end

  def find_user_for_confirmation
    email = params[:email]
    confirmation_token = params[:confirmation_token]

    return redirect_to root_path if email.blank? && confirmation_token.blank?

    @user = User.by_email(email)
                .by_confirmation_token(confirmation_token)
                .first
  end
end
