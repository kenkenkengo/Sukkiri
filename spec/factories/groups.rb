FactoryBot.define do
  factory :group do
    name { Faker::Color.color_name }
    admin_user_id { "1" }
  end
end
