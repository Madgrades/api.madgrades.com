class ApiController < ActionController::Base
  before_action :set_json, :require_auth

  private
    def set_json
      request.format = :json unless params[:format]
    end

    def require_auth
      unless Rails.env == 'development'
        return true if authenticate
        render json: {error: 'Unauthorized'}, status: 401
      end
    end

    def authenticate
      # Support both 'Token token=...' and raw token in Authorization header
      auth_header = request.headers['Authorization']
      if auth_header.present?
        prefix = 'Token token='
        token = if auth_header[0, prefix.length].casecmp(prefix).zero?
          auth_header[prefix.length..-1].strip
        else
          auth_header.strip
        end
        return User.find_by(api_token: token)
      end
      # Fallback to Rails' built-in token auth (for compatibility)
      authenticate_with_http_token do |token, options|
        User.find_by(api_token: token)
      end
    end
end
