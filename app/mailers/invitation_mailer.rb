class InvitationMailer < ApplicationMailer
  default from: 'no_reply@getstudygroup.herokuapp.com'
  
  def invite_email(invitation)
    @invitation = invitation
    @url = 'https://getstudygroup.herokuapp.com'
    mail(to: @invitation.email, subject: "Studygroup Invitation from #{@invitation.inviter_name}")
  end
end
