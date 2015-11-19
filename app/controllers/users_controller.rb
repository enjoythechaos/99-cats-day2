class UsersController < ApplicationController
  before_action :redirect_logged_in_users, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    session[:session_token] = @user.session_token
    if @user.save
      redirect_to cats_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
