class V1::InstructorsController < ApiController
  def index
    query = params[:query]

    if query.present?
      @instructors = Instructor.search_with_page(params[:query], params[:page], params[:per_page])
    else
      @instructors = Instructor.page(params[:page]).per(params[:per_page])
    end
  end

  def show
    @instructor = Instructor.find(params[:id])
  end
end
