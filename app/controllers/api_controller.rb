class ApiController < ActionController::Base
  before_action :set_json, :require_auth

  private
    def set_json
      request.format = :json unless params[:format]
    end

    def require_auth
      return true if authenticate
      render json: {error: 'Unauthorized'}, status: 401
    end

    def authenticate
      authenticate_with_http_token do |token, options|
        User.find_by(api_token: token)
      end
    end
end
