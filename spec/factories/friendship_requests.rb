# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship_request do
#     sender_id 1
#     receiver_id 2
    status "pending"
  end
end
