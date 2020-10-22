FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.unique.username }
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password }

    factory :user_with_posts do
      transient do
        posts_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
