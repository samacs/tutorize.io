class MyCoursesController < ApplicationController
  before_action :require_teacher

  before_action :set_course, only: %i[edit update]

  def index
    @courses = current_user.courses.includes(:lessons).with_rich_text_description_and_embeds
  end

  def new
    @course = current_user.courses.new
  end

  def edit; end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
      redirect_to my_courses_path, success: t('.success', course_name: @course.name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      redirect_to my_courses_path, success: t('.success', course_name: @course.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :cover_image)
  end

  def set_course
    @course = current_user.courses.with_rich_text_description_and_embeds.find(params[:id])
  end
end
