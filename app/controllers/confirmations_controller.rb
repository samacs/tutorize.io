class ConfirmationsController < FrontendController
  before_action :require_no_user

  add_body_classes 'resend-confirmation'

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
