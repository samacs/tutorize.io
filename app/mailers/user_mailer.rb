class UserMailer < ApplicationMailer
  before_action :set_user

  def confirmation_email
    mail(subject: t('.subject', user_name: @user.first_name), to: @user.email)
  end

  def teacher_welcome_email
    mail(subject: t('.subject', user_name: @user.first_name), to: @user.email)
  end

  def student_welcome_email
    mail(subject: t('.subject', user_name: @user.first_name), to: @user.email)
  end

  def password_reset_email
    mail(subject: t('.subject', user_name: @user.first_name), to: @user.email)
  end

  private

  def set_user
    @user = params[:user]
  end
end
