class FriendshipRequestsController < ApplicationController
  before_action :logged_in_user
  
  def create
    user = User.find(params[:receiver_id])
    current_user.send_friendship_request(user)
    flash[:success] = "Friendship request sent"
    redirect_to user
  end
  
  def update
    # First, find the friendship request
    @friendship_request = FriendshipRequest.where(receiver_id: current_user.id, sender_id: params[:sender_id])
    if params[:status] = "accepted"
      @friendship_request.accept
    elsif params[:status] = "declined"
      @friendship_request.decline
    end
    redirect_to user_path(current_user)
  end
  
  private
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
end
