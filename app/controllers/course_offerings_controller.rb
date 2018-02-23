class CourseOfferingsController < ApplicationController
  def show
    @course_offering = CourseOffering.find(params[:id])
  end
end
