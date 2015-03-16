require 'rails_helper'

describe Event do
  
  it "has a valid factory" do
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
  
  context "#past_events" do
    it "returns past events" do
      past_event = create(:event, start_time: 24.hours.ago, end_time: 25.hours.ago)
      other_event = create(:event, start_time: 24.hours.ago, end_time: 25.hours.ago)
      past_events = expect(Event.past_events).to eq [past_event, other_event]
    end
    
    it "doesn't return events that are still upcoming" do
      current_event = create(:event, start_time: Time.now + 2.hours, end_time: Time.now + 3.hours)
      expect(Event.past_events).to_not include current_event
    end
  end
  
  context "#upcoming_events" do
    it "returns current and upcoming events" do
      current_event = create(:event, start_time: Time.now + 1.hours)
      upcoming_event = create(:event)
      past_event = create(:event, start_time: 24.hours.ago, end_time: 25.hours.ago)
      expect(Event.upcoming_events).to eq [current_event, upcoming_event]
    end
    it "doesn't return past events" do
      current_event = create(:event, start_time: Time.now)
      other_event = create(:event)
      past_event = create(:event, start_time: 24.hours.ago, end_time: 25.hours.ago)
      expect(Event.upcoming_events).to_not include past_event
    end
  end
  
end