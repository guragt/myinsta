class Relationship < ApplicationRecord
  scope :pending, -> { where(status: :pending) }

  enum status: { pending: 0, active: 1 }

  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :status, presence: true
end
