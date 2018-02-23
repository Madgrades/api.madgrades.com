class PagesController < ApplicationController
  def index
    render json: {message: 'hey'}
  end
end
