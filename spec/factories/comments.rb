FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user
    association :parent, factory: :post
  end
end
