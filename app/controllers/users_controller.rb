class UsersController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @invitation = Invitation.new
    @current_city = City.find(current_user.city_id)
    if params[:tag]
      users = User.tagged_with(params[:tag])
      @users = users.select {|u| u.city_id == current_user.city_id }
    else
      @users = User.where(city: current_user.city)
    end
  end
  
  def show
    @user = User.find(params[:id])
    @friends = @user.friends.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
  def correct_user
    user = User.find(params[:id])
    redirect_to login_path unless current_user?(user)
  end
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :tag_list)
  end
end
