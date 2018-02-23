class GradeDistributionsController < ApplicationController
  def show
    @grade_distribution = GradeDistribution.find(params[:id])
  end
end
