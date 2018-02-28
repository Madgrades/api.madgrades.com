class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :courses]

  def index
    @subjects = Subject.all.page(params[:page]).per(params[:per_page])
  end

  def search
    @subjects = Subject.search_with_page(params[:query], params[:page], params[:per_page])
    render :index
  end

  def show
  end

  def courses
    @courses = @subject.courses.page(params[:page]).per(params[:per_page])
    render 'courses/index'
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end
end
