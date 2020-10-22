class Post < ApplicationRecord
  belongs_to :user

  validates :description, length: { maximum: 2000 }
  validates :image, presence: true,
                    file_size: { less_than: 5.megabytes }

  acts_as_paranoid

  mount_uploader :image, ImageUploader
end
