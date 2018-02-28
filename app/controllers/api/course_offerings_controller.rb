class Api::CourseOfferingsController < ApiController
  def show
    @course_offering = CourseOffering.find(params[:id])
  end
end
