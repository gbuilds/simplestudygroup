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
    expect(subject.find_inivitations_by_email).to include invitation
  end
  # checks the database for invitations matching a certain email
  # builds friend requests for invitation creator to user w/ user email
end