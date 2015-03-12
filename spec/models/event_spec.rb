require 'rails_helper'

describe Event do
  
  it "is valid with a title, description, start and end datetime" do
    event = Event.new(title: "Event title",
      description: "this is the event",
      start_time: Time.now + 2.hours,
      end_time: Time.now + 4.hours)
    expect(event).to be_valid
  end
  
  it "is invalid without a title" do
    event = build(:event, title: nil)
    event.valid?
    expect(event.errors[:title]).to include("can't be blank")
  end
  
  it "is invalid without a description" do
    event = build(:event, description: nil)
    event.valid?
    expect(event.errors[:description]).to include("can't be blank")
  end
  
  it "is invalid without a start datetime" do
    event = build(:event, start_time: nil)
    event.valid?
    expect(event.errors[:start_time]).to include("can't be blank")
  end
  
  it "is invalid without an end datetime" do
    event = build(:event, end_time: nil)
    event.valid?
    expect(event.errors[:end_time]).to include("can't be blank")
  end
  
end