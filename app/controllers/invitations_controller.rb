class InvitationsController < ApplicationController
  before_action :logged_in_user
  
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      # send an email to that address
      # redirect to somewhere  
      # can't invite an email more than once
    else
      flash[:danger] = "Invitation was not sent"
    end
  end
  
  
  private
  
  def invitation_params
    params.require(:invitation).permit(:email, :inviter_id)
  end
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
end