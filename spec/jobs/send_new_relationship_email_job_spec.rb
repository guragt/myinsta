require 'rails_helper'

RSpec.describe SendNewRelationshipEmailJob, type: :job do
  let!(:relationship) { create(:relationship) }

  describe '#perform' do
    before do
      allow(RelationshipMailer).to receive_message_chain(:new_follower, :deliver_now)
    end

    it 'calls Relationshipmailer' do
      described_class.new.perform(relationship.id)
      expect(RelationshipMailer).to have_received(:new_follower).with(relationship)
    end

    it 'does not call Relationshipmailer if ticket not exist' do
      described_class.new.perform(100)
      expect(RelationshipMailer).to_not have_received(:new_follower)
    end
  end
end
