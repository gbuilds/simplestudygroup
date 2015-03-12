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
    expect(user.errors[:first_name]).to include("must be at least 2 characters")
  end
  it "is invalid with a firstname less than 2 characters" do
    user = build(:user, last_name: "A")
    user.valid?
    expect(user.errors[:last_name]).to include("must be at least 2 characters")
  end
  it "is invalid without a city association" do
    user = build(:user, city_id: nil)
    user.valid?
    expect(user.errors[:city_id]).to include("can't be blank")
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
    user.valid?
    expect(user.errors[:password]).to include("don't match")
  end
  it "is invalid with a duplicate email address" do
    create(:user, email: "email@example.com")
    user = build(:user, email: "email@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  it "returns a User's full name as a string" do
    user = build(:user)
    expect(user.full_name).to eq "Jeff Bridges"    
  end
end