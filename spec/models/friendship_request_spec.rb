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
      fr = build(:friendship_request)
      fr.accept
      expect(fr.status).to eq "accepted"
      expect(user.friends).to include(friend)
      expect(friend.friends).to include(user)
    end
    it "declines a request" do
      user = create(:user, id: 1)
      friend = create(:user, id: 2)
      fr = build(:friendship_request)
      fr.decline
      expect(fr.status).to eq "declined"
      expect(user.friends).to_not include(friend)
      expect(friend.friends).to_not include(friend)
    end
  
    it "checks if a friendship is requestable"
  
    it "returns the sending user" do
      user = create(:user, id: 1)
      friend = create(:user, id: 2)
      fr = build(:friendship_request)
      expect(fr.sending_user).to eq fr.sender
    end
end
