FactoryBot.define do
  factory :user do
    sequence(:username)  { |n| Faker::Internet.user_name } 
    password    "123456"
  end
end
