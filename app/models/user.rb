class User < ApplicationRecord
  scope :native_auth, -> { where(provider: nil) }
  scope :okta_auth,   -> { where(provider: 'oktaoauth') }

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
         :recoverable, :rememberable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: [:oktaoauth]

  acts_as_paranoid

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    if (user = find_by(email: auth['info']['email']))
      user.update(edit_okta_params(auth))
    else
      user = create(new_okta_params(auth))
    end

    user
  end

  def self.new_okta_params(auth)
    {
      name: auth['info']['name'],
      nickname: auth['extra']['raw_info']['nickname'],
      email: auth['info']['email'],
      provider: auth['provider'],
      uid: auth['uid'],
      password: Devise.friendly_token[0, 20]
    }
  end

  def self.edit_okta_params(auth)
    {
      provider: auth['provider'],
      uid: auth['uid'],
      password: Devise.friendly_token[0, 20]
    }
  end

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

  def admin?
    false
  end

  def show_content_for?(user)
    user.public? || following_status_for(user) == 'active'
  end

  def show_post_for?(user)
    self == user || show_content_for?(user)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def auth_provider
    provider || I18n.t('.native')
  end
end
