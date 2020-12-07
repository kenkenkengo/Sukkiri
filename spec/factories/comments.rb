FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.word }
    user
    post
  end
end
