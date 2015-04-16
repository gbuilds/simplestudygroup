require 'rails_helper'

context "Signup_Processor" do
  
  subject { SignupProcessor.new(user) }
  it "creates a valid signup processor object" do
    expect(subject.class).to eq SignupProcessor
  end
  # checks the database for invitations matching a certain email
  # builds friend requests for invitation creator to user w/ user email
end