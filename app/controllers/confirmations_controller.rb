class ConfirmationsController < ApplicationController
  skip_before_action :require_user

  before_action :require_no_user

  def new; end

  def create
    result = ResendConfirmationService.call(email: params[:email], force: true)
    if result.success?
      redirect_to root_path, success: t('.success')
    else
      flash.now[:error] = t('.error')

      render :new
    end
  end
end
