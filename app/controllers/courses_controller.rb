class CoursesController < ApplicationController
  def index
    @courses = Course.all.page(params[:page]).per(params[:per_page])
  end

  def show
    @course = Course.find(params[:id])
  end

  def search
    @courses = Course.search(params[:query]).page(params[:page]).per(params[:per_page])
    render :index
  end
end
