class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_json

  def set_json
    request.format = :json unless params[:format]
  end
end
