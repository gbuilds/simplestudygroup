class SignupProcessor
  attr_accessor :user
  
  def initialize(user)
    @user = user
  end
  
  def find_invitations_by_email
    Invitation.where(email: @user.email)
  end
  
  def create_friendship_requests
    invitations = self.find_invitations_by_email
    invitations.each do |inv|
      FriendshipRequest.create(sender_id: inv.inviter_id, receiver_id: @user.id, status: "pending")
    end
  end
  
end