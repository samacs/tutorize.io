class CoursesController < ApplicationController
  before_action :set_course, only: %i[show]

  def index
    @pagy, @courses = pagy(Course.newest)
  end

  def show; end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
