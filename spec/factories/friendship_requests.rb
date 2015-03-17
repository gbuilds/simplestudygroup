# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship_request do
    sender nil
    receiver nil
    status "MyString"
  end
end
