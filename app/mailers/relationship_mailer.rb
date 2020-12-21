class RelationshipMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.relationship_mailer.new_follower.subject
  #
  def new_follower(relationship)
    @relationship = relationship

    mail(to: @relationship.followed.email,
         subject: @relationship.active? ? t('.follower') : t('.request'))
  end
end
