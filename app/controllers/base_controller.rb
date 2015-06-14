class BaseController < ApplicationController
  protect_from_forgery
  helper_method :current_user

  private
  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
