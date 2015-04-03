require 'rails_helper'

describe User do
  
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
  
  it "is invalid without a firstname" do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  
  it "is invalid without a lastname" do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  
  it "is invalid with a firstname less than 2 characters" do
    user = build(:user, first_name: "A")
    user.valid?
    expect(user.errors[:first_name]).to include("is too short (minimum is 2 characters)")
  end
  
  it "is invalid with a firstname less than 2 characters" do
    user = build(:user, last_name: "A")
    user.valid?
    expect(user.errors[:last_name]).to include("is too short (minimum is 2 characters)")
  end
  
  it "is invalid without an email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  it "is invalid without a password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
  
  it "is invalid if password and password confirmation don't match" do
    user = build(:user, password: "password", password_confirmation: "wrongthing")
    expect(user).to_not be_valid
  end
  
  it "is invalid with a duplicate email address" do
    create(:user, email: "example@example.com")
    user = build(:user, email: "example@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  it "returns a User's full name as a string" do
    user = build(:user, first_name: "Jeff", last_name: "Bridges")
    expect(user.full_name).to eq "Jeff Bridges"    
  end
  
  it "registers for an event" do
    user = create(:user)
    event = create(:event)
    user.register(event)
    expect(user.attended_events).to include(event)
  end
  context "#feed" do
    it "returns a friend's events" do
      user = create(:user)
      friend = create(:user)
      user.friends << friend
      event = create(:event, creator_id: friend.id)
      expect(user.feed).to include(event)
    end
    
    it "returns a users events" do
      user = create(:user)
      event = create(:event, creator_id: user.id)
      expect(user.feed).to include(event)
    end
  end
  
end