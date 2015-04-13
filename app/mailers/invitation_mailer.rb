class InvitationMailer < ApplicationMailer
  default from: 'no_reply@getstudygroup.com'
  
  def invite_email(invitation)
    @invitation = invitation
    @url = 'getstudygroup.com'
    mail(to: @invitation.email, subject: "Studygroup Invitation from #{@invitation.inviter_name}")
  end
end
