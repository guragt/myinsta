FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentence }
    image do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'post_image.png'))
    end
    user

    trait :with_likes do
      after(:create) do |post|
        create_list(:like, 2, likeable: post)
      end
    end
  end
end
