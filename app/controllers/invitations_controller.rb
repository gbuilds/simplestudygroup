class InvitationsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.unsent? && @invitation.save
      InvitationMailer.invite_email(@invitation).deliver_now
      flash[:success] = "Invitation sent"
      redirect_to  request.referrer
    elsif !@invitation.unsent?
      flash[:danger] = "Already sent an invite to this person"
      redirect_to request.referrer
    else
      flash[:danger] = "Invitation was not sent"
      redirect_to request.referrer
    end
  end
  
  
  private
  
  def invitation_params
    params.require(:invitation).permit(:email).merge(inviter_id: current_user.id)
  end
  
  def logged_in_user
    unless user_signed_in?
      flash[:warning] = "You are not signed in."
      redirect_to new_user_session_path
    end
  end
  
end