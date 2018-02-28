class SubjectsController < ApplicationController
  before_action :set_subject, except: :index

  def index
    @subjects = Subject.all
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
