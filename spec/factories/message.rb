FactoryBot.define do
  factory :message do
    sequence(:body)  { |n| Faker::ChuckNorris.fact }
    user
    chat
  end
end
