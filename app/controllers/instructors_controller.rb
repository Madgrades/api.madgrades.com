class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.page(params[:page]).per(params[:per_page])
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def search
    @instructors = Instructor.search_with_page(params[:query], params[:page], params[:per_page])
    render :index
  end
end
