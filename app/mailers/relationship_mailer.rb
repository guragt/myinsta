class RelationshipMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.relationship_mailer.new_follower.subject
  #
  def new_follower(relationship)
    @follower = relationship.follower
    @followed = relationship.followed

    mail(to: @followed.email, subject: t('.subject'))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.relationship_mailer.new_follow_request.subject
  #
  def new_follow_request(relationship)
    @follower = relationship.follower
    @followed = relationship.followed

    mail(to: @followed.email, subject: t('.subject'))
  end
end
