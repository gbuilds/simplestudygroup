FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    password   "password"
    password_confirmation "password"
    association :city
    email { Faker::Internet.email }
    description { "a"*10 }
  end
end