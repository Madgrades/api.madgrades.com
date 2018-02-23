class SectionsController < ApplicationController
  def show
    @section = Section.find(params[:id])
  end
end
