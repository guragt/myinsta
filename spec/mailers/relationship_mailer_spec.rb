require 'rails_helper'

RSpec.describe RelationshipMailer, type: :mailer do
  describe 'new_follower' do
    let!(:relationship) { create(:relationship) }
    let!(:mail) { RelationshipMailer.new_follower(relationship) }

    it 'renders the headers' do
      expect(mail.subject).to eq('New follow request')
      expect(mail.to).to eq([relationship.followed.email])
      expect(mail.from).to eq(['myinstaror@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(relationship.followed.name)
      expect(mail.body.encoded).to match(relationship.follower.nickname)
    end
  end
end
