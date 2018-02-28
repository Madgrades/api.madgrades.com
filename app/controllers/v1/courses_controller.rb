class V1::CoursesController < ApiController
  def index
    @courses = Course.all.page(params[:page]).per(params[:per_page])
  end

  def show
    @course = Course.find(params[:id])
  end

  def search
    @courses = Course.search_with_page(params[:query], params[:page], params[:per_page])
    render :index
  end
end
