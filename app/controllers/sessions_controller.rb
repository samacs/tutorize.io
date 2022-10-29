class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
