FactoryBot.define do
  factory :post do
    content { Faker::Color.color_name }
    trait :image do
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image.jpg')) }
    end

    trait :other_image do
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_image2.jpg')) }
    end
  end
end
