class ProfileController < ApplicationController
  before_action :set_date_range

  def edit
    @week_availabilities = current_user.availabilities.order(:from, :to).weekdays.group_by(&:weekday)
    @availabilities = current_user.availabilities.where.not(date: nil).order(:from, :to).for_date([@from..@to])
    @available_time_slots = current_user.availabilities.available_time_slots(@from, @to)
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, success: 'Profile updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :avatar)
  end

  def set_date_range
    @start_date = params.fetch(:start_date, Date.current).to_datetime
    @from = @start_date.at_beginning_of_month.at_beginning_of_week.at_beginning_of_day
    @to = @start_date.at_end_of_month.at_end_of_week.at_end_of_day
  end
end
