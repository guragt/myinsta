class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  inverse_of: :follower,
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   inverse_of: :followed,
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :nickname, presence: true,
                       uniqueness: { case_sensitive: true },
                       length: { maximum: 30 },
                       format: { without: /\s/, message: "doesn't allow spaces" }
  validates :avatar, file_size: { less_than: 1.megabytes }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader
end
