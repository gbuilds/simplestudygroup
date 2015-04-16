require 'rails_helper'

context "Signup_Processor" do
  let! (:user) { FactoryGirl.create(:user)}
  
  subject { SignupProcessor.new(user) }
  
  it "creates a valid signup processor object" do
    expect(subject.class).to eq SignupProcessor
  end
  
  it "should contain a user object on initialize" do
    expect(subject.user.class).to eq User
  end
  
  it "responds to proper methods" do
    expect(subject.respond_to?(:find_invitations_by_email)).to be true
  end
  
  it "finds invitations matching user's email" do
    inviter = FactoryGirl.create(:user)
    invitation = FactoryGirl.create(:invitation, inviter_id: inviter.id, email: user.email)
    expect(subject.find_invitations_by_email).to include invitation
  end
  
  it "builds proper friendship requests for each invitation" do
    inviter = FactoryGirl.create(:user)
    invitation = FactoryGirl.create(:invitation, inviter_id: inviter.id, email: user.email)
    subject.create_friendship_requests
    friendship_request = FriendshipRequest.first
    expect(friendship_request.sender_id).to eq inviter.id
    expect(friendship_request.receiver_id).to eq user.id
  end
end