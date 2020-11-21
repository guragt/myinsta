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

    trait :with_following do
      after(:create) do |user|
        user.following << create_list(:user, 2)
      end
    end

    trait :with_followers do
      after(:create) do |user|
        user.followers << create_list(:user, 2)
      end
    end

    trait :with_likes do
      after(:create) do |user|
        create_list(:like, 2, user: user)
      end
    end
  end
end
