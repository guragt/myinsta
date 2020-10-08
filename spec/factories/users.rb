FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.unique.username }
    email { Faker::Internet.unique.safe_email }
    password { Faker::Internet.password }
  end
end