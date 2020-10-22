FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.unique.username }
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password }

    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 5, user: user)
      end
    end
  end
end
