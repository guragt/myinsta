class Comment < ApplicationRecord
  default_scope -> { order(:created_at) }

  belongs_to :user
  belongs_to :parent, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, class_name: 'Comment', as: :parent, dependent: :destroy

  validates :body, presence: true,
                   length: { maximum: 1000 }

  acts_as_paranoid
end
