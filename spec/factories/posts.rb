FactoryBot.define do
  factory :post do
    description { Faker::Lorem.sentences(number: 1) }
    image do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'files', 'post_image.png'))
    end
    user
  end
end
