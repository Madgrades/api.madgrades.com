class V1::CourseOfferingsController < ApiController
  def show
    @course_offering = CourseOffering.find(params[:id])
  end
end
