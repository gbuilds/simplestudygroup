FactoryGirl.define do
  factory :event do
    title { "My Event" }
    description { "This is the description for my event" }
    start_time { Time.now + 10.hours }
    end_time   { Time.now + 12.hours }
  end
end