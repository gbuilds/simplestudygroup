class UsersController < ApplicationController
  before_action :logged_in_user?
  
  def index
    @users = User.where(city: current_user.city)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def logged_in_user?
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
end
