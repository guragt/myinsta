class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
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
                       uniqueness: { case_sensitive: true,
                                     conditions: -> { with_deleted } },
                       length: { maximum: 30 },
                       format: { without: /\s/, message: "doesn't allow spaces" }
  validates :email, uniqueness: { case_sensitive: false,
                                  conditions: -> { with_deleted } }
  validates :avatar, file_size: { less_than: 1.megabytes }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_paranoid

  mount_uploader :avatar, AvatarUploader

  def following_status_for(other_user)
    return 'not_following' unless following.include?(other_user)

    Relationship.find_by(follower_id: id, followed_id: other_user.id).status
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                    WHERE follower_id = :user_id AND status = 1"
    Post.where("user_id IN (#{following_ids})
                OR user_id = :user_id", user_id: id).order(created_at: :desc)
  end

  def public?
    !private?
  end

  def show_content_for?(user)
    user.public? || following_status_for(user) == 'active'
  end

  def show_post_for?(user)
    self == user || show_content_for?(user)
  end
end
