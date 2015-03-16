FactoryGirl.define do
  factory :event do
    title { "#{Faker::Name.first_name}'s amazing event" }
    description "This is the description for my event"
    start_time Time.now + 10.hours
    end_time   Time.now + 12.hours
  end
end