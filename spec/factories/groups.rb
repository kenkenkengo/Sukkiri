FactoryBot.define do
  factory :group do
    name { Faker::Code.ean }
    admin_user_id { "1" }
  end
end
