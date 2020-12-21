# Preview all emails at http://localhost:3000/rails/mailers/relationship_mailer
class RelationshipMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/relationship_mailer/new_follower
  def new_follower
    RelationshipMailer.new_follower(Relationship.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/relationship_mailer/new_follow_request
  def new_follow_request
    RelationshipMailer.new_follow_request(Relationship.first)
  end
end
