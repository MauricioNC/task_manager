class ApplicationController < ActionController::Base
  before_action :authorize

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    !!current_user
  end

  def authorize
    unless logged_in?
      flash[:error] = "Please login first to reach this page."
      redirect_to login_path
    end
  end
end
