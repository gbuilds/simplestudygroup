class FriendshipRequest < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  # Accept friendship request
  def accept
    update_attribute(:status, "accepted")
    receiver.build_friendships(self.sender)
  end
  
  # Decline friendship request
  def decline
    update_attribute(:status, "declined")
  end
  
  # Get the user who sent the request
  def sending_user
    User.find_by(id: self.sender_id)
  end
  
  # Return false unless 2 users can send each other a friend request
  def FriendshipRequest.requestable?(user, requestee)
    if user.sent_frequests.any? { |req| req.receiver == requestee }
      return false
    elsif user.received_frequests.any? {|req| req.sender == requestee }
      return false
    elsif user.friends?(requestee)
      return false
    else
      true
    end
  end

end
