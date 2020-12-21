class Relationship < ApplicationRecord
  enum status: { pending: 0, active: 1, declined: 2 }

  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :status, presence: true

  after_create :send_relationship_notification, unless: -> { Rails.env.test? }

  private

  def send_relationship_notification
    RelationshipMailer.new_follower(self).deliver_later
  end
end
