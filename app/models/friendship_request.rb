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
  
  # Return false if there's an existing friend request between 2 users
  def FriendshipRequest.requestable?(user1, user2)
    (user1.all_frequests & user2.all_frequests).none?
  end
  
end
