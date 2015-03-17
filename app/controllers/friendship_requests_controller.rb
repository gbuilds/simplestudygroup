class FriendshipRequestsController < ApplicationController
  before_action :logged_in_user
  
  def create
    user = User.find(params[:receiver_id])
    current_user.request_friendship(user)
    flash[:success] = "Friendship request sent"
    redirect_to user
  end
  
  def update
  end
  
  private
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
end
