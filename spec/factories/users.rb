FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }

    trait :user_with_groups do
      after(:create) do |user|
        temp_group = create(:group, admin_user_id: user.id)
        create(:belonging, user: user, group: temp_group)
      end
    end

    trait :user_with_groups_and_posts do
      after(:create) do |user|
        temp_group = create(:group, admin_user_id: user.id)
        create(:belonging, user: user, group: temp_group)
        create(:post, :image, user: user, group: temp_group)
      end
    end

    trait :other_user_with_groups_and_posts do
      after(:create) do |user|
        temp_group = create(:group, admin_user_id: user.id)
        create(:belonging, user: user, group: temp_group)
        create(:post, :other_image, user: user, group: temp_group)
      end
    end

    trait :user_with_groups_and_posts_and_likes do
      after(:create) do |user|
        temp_group = create(:group, admin_user_id: user.id)
        create(:belonging, user: user, group: temp_group)
        post = create(:post, :image, user: user, group: temp_group)
        create(:like, user: user, post: post)
      end
    end

    trait :user_with_groups_and_posts_and_comments do
      after(:create) do |user|
        temp_group = create(:group, admin_user_id: user.id)
        create(:belonging, user: user, group: temp_group)
        post = create(:post, :image, user: user, group: temp_group)
        create(:comment, user: user, post: post)
      end
    end
  end
end
