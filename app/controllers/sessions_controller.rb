class SessionsController < ApplicationController
  before_action :redirect_logged_in_users, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    # Verify that everything worked
    @user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    @user ? login!(@user) : (render :new)
  end

  def destroy
    session[:session_token] = nil
    current_user.reset_session_token! if current_user
    redirect_to cats_url
  end
end
