require 'rails_helper'

RSpec.describe FriendshipRequest, :type => :model do
    it "has a valid factory" do
      fr = FriendshipRequest.new(sender_id: 1,
      receiver_id: 1,
      status: 'pending')
      expect(fr).to be_valid
    end
    it "accepts a request"
    it "declines a request"
    it "checks if a friendship is requestable"
    it "returns the sending user"
end
