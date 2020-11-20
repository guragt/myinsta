class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def likeable_likes_count
    likeable.likes.count
  end
end
