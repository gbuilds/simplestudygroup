class FriendshipRequest < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  
  def accept
    update_attribute(:status, "accepted")
    receiver.build_friendships(self.sender)
  end
  
  def decline
    update_attribute(:status, "declined")
  end
  
  def sending_user
    User.find_by(id: self.sender_id)
  end
end
