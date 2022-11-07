class EnrollmentsController < ApplicationController
  before_action :set_course
  before_action :set_lesson
  before_action :set_enrollment, only: :show

  def show; end

  def new
    @enrollment = current_user.enrollments.new
    @available_time_slots = @lesson.available_time_slots(from_date, to_date)
  end

  def create
    @enrollment = @lesson.enroll(current_user, start_time, end_time)
    if @enrollment
      redirect_to course_lesson_enrollment(@course, @lesson, @enrollment),
                  success: "Successfully enrolled to #{@course.name} - #{@lesson.name}"
    else
      @time_slot = (enrollment_params[:start_time]..enrollment_params[:end_time])
      @date = enrollment_params[:date]
      render :update_form
    end
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:start_time, :end_time, :date)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_enrollment
    @enrollment = current_user.enrollments.find(params[:id])
  end

  def start_date
    return @start_date if @start_date.present?

    current_date = Time.current
    @start_date = params.fetch(:start_date, current_date).to_datetime
    @start_date = current_date if start_date.before?(current_date) || start_date.month == current_date.month
  end

  def from_date
    @from_date ||= if start_date > Time.current
                     start_date.at_beginning_of_month.at_beginning_of_weeke
                   else
                     start_date
                   end
  end

  def to_date
    @to_date ||= start_date.at_end_of_month.at_end_of_week.at_end_of_day
  end

  def start_time
    @start_time ||= Date.parse(enrollment_params[:date]) + enrollment_params[:start_time].to_d.hours
  end

  def end_time
    @end_time ||= Date.parse(enrollment_params[:date]) + enrollment_params[:end_time].to_d.hours
  end
end
