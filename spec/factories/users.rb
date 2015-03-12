FactoryGirl.define do
  factory :user do
    first_name "Jeff"
    last_name  "Bridges"
    password   "password"
    password_confirmation "password"
    city_id    1
    description "I'm a test user named Jeff. I'm interested in breaking things."
    sequence(:email) { |n| "jeffbridges#{n}@example.com" }
  end
end