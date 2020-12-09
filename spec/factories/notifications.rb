FactoryBot.define do
  factory :notification do
    post_id { 1 }
    action_type { 1 }
    comment { "" }
    from_user_id { 2 }
    user
  end
end
