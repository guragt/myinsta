class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :parent, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, class_name: 'Comment', as: :parent, dependent: :destroy

  validates :body, presence: true,
                   length: { maximum: 2000 }

  acts_as_paranoid
end
