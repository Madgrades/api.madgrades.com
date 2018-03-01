class V1::TermsController < ApplicationController
  def index
    offerings = CourseOffering.select(:term_code).distinct
    result = {}
    offerings.each do |offering|
      result[offering.term_code] = offering.term_name
    end
    render json: result
  end
end
