require 'rails_helper'

describe User do
  it "is valid with an email, first name and last name of length 2, and city" do
    user = User.new(
      first_name: "Gordie",
      last_name: "Smith",
      email: "validemail@internet.com",
      password: "password",
      password_confirmation: "password",
      city_id: 1)
    expect(user).to be_valid
  end
  
  it "is invalid without a firstname" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end
  
  it "is invalid without a lastname" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end
  it "is invalid with a firstname less than 2 characters"
  it "is invalid with a lastname less than 2 characters"
  it "is invalid without a city association"
  it "is invalid without an email"
  
  it "is invalid with a duplicate email address" do
    User.create(first_name: "Gordie", last_name: "Smith", password: "password", password_confirmation: "password",
      email: "valid@email.com")
    user = User.new(first_name: "Jeff", last_name: "Bridges", password: "password", password_confirmation: "password", email: "valid@email.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
  
  it "returns a User's full name as a string" do
    user = User.new(first_name: "Gordie", last_name: "Smith", password: "password", password_confirmation: "password",
      email: "valid@email.com")
    expect(user.full_name).to eq "Gordie Smith"    
  end
end