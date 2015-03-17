class FriendshipRequest < ActiveRecord::Base
  belongs_to :sender, class: "User"
  belongs_to :receiver, class: "User"
end
