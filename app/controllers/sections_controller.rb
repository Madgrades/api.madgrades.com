class SectionsController < ApplicationController
  def index
    @sections = Section.page(params[:page])
  end

  def show
    @section = Section.find(params[:id])
  end
end
