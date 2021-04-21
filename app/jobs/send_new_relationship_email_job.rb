class SendNewRelationshipEmailJob < ApplicationJob
  queue_as :mailers

  def perform(relationship_id)
    relationship = Relationship.find_by(id: relationship_id)
    return if relationship.nil?

    RelationshipMailer.new_follower(relationship).deliver_now
  end
end
