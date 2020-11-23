class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :parent, dependent: :destroy

  validates :description, length: { maximum: 2000 }
  validates :image, presence: true,
                    file_size: { less_than: 5.megabytes }

  acts_as_paranoid

  mount_uploader :image, ImageUploader
end
