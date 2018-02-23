class InstructorsController < ApplicationController
  def index
    @instructors = Instructor.page(params[:page])
  end

  def show
    @instructor = Instructor.find(params[:id])
  end

  def search
    @instructors = Instructor.search(params[:query]).page(params[:page])
    render :index
  end
end
