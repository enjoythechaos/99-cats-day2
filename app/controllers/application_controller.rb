class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    user.session_token = User.generate_session_token
    session[:session_token] = @user.session_token
    user.save
    redirect_to cats_url
  end

  def redirect_logged_in_users
    redirect_to cats_url if current_user
  end

  helper_method :current_user
end


# @user.session_token = User.generate_session_token
# @user.save
# session[:session_token] = @user.session_token
# redirect_to cats_url
