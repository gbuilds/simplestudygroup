class FriendshipRequestsController < ApplicationController
  before_action :logged_in_user
  
  def create
    user = User.find_by(id: params[:receiver_id])
    if FriendshipRequest.requestable?(current_user, user)
      current_user.send_friendship_request(user)
      flash[:success] = "Friendship request sent"
      redirect_to user
    else
      flash[:danger] = "Unable to request friendship. You may already be friends or have a pending request."
      redirect_to user
    end

  end
  
  def update
    @friendship_request = FriendshipRequest.find_by(id: params[:id])
    sender = @friendship_request.sender
    if params[:status] = "accepted"
      @friendship_request.accept
      redirect_to user_path(sender)
    elsif params[:status] = "declined"
      @friendship_request.decline
      redirect_to user_path(sender)
    end
  end
  
  private
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
end
