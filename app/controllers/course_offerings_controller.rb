class CourseOfferingsController < ApplicationController
  def index
    @course_offerings = CourseOffering.all
  end

  def show
    @course_offering = CourseOffering.find(params[:id])
  end
end
