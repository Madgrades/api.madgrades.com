class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
      if @current_user.nil?
        self.current_user = nil
      end
    end
    @current_user
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
end
