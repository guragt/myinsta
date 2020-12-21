require 'rails_helper'

RSpec.describe RelationshipMailer, type: :mailer do
  describe 'new_follower' do
    let(:mail) { RelationshipMailer.new_follower }

    it 'renders the headers' do
      expect(mail.subject).to eq('New follower')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end

  describe 'new_follow_request' do
    let(:mail) { RelationshipMailer.new_follow_request }

    it 'renders the headers' do
      expect(mail.subject).to eq('New follow request')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
