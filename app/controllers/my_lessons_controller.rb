class MyLessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: %i[edit update]

  def index
    @lessons = @course.lessons
  end

  def new
    @lesson = @course.lessons.new
  end

  def edit; end

  def create
    @lesson = current_user.lessons.new(lesson_params.merge(course_id: @course.id))
    if @lesson.save
      redirect_to my_course_lessons_path, success: "Lesson #{@lesson.name} created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to my_course_lessons_path, success: "Lesson #{@lesson.name} updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :duration, :cover_image)
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def set_course
    @course = current_user.courses.find(params[:my_course_id])
  end
end
