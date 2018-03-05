class V1::SubjectsController < ApiController
  before_action :set_subject, only: [:show, :courses]

  def index
    if params[:query].present?
      @subjects = Subject.search_with_page(params[:query], params[:page], params[:per_page])
    else
      @subjects = Subject.all.page(params[:page]).per(params[:per_page])
    end
  end

  def show
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end
end
