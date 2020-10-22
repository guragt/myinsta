FactoryBot.define do
  factory :post do
    description { "MyText" }
    image { "MyString" }
    commentable { false }
    user { nil }
    deleted_at { "2020-10-21 16:10:27" }
  end
end
