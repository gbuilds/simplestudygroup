require 'rails_helper'

RSpec.describe FriendshipRequest, :type => :model do
  
    it "has a valid factory" do
      fr = FriendshipRequest.new(sender_id: 1,
      receiver_id: 2,
      status: 'pending')
      expect(fr).to be_valid
    end
  
    it "accepts a request" do
      user = create(:user, id: 1)
      friend = create(:user, id: 2)
      fr = create(:friendship_request, sender_id: 1, receiver_id: 2)
      fr.accept
      expect(fr.status).to eq "accepted"
      expect(user.friends).to include(friend)
      expect(friend.friends).to include(user)
    end
  
    it "declines a request" do
      user = create(:user, id: 1)
      friend = create(:user, id: 2)
      fr = create(:friendship_request)
      fr.decline
      expect(fr.status).to eq "declined"
      expect(user.friends).to_not include(friend)
      expect(friend.friends).to_not include(friend)
    end
  
    it "returns true if a friendship is requestable" do
      x = create(:user, id: 1)
      y = create(:user, id: 2)
      expect(FriendshipRequest.requestable?(x, y)).to eq true
    end
  
    it "returns false if a friendship is not requestable" do
      x = create(:user, id: 1)
      y = create(:user, id: 2)
      fr = create(:friendship_request, sender_id: x.id, receiver_id: y.id )
      expect(FriendshipRequest.requestable?(y, x)).to eq false
    end

end
