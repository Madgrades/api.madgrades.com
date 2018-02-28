class V1::SectionsController < ApiController
  def show
    @section = Section.find(params[:id])
  end
end
