class UsersController < ApplicationController
  decorates_assigned :user

  add_body_classes 'sign-up'

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # TODO: Call a service to finish the sign up process:
        #       * Assign the given role
        #       * Send the confirmation email
        # TODO: Update this to redirect to the sign in form.
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :terms_of_service)
  end
end
