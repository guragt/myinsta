require 'rails_helper'

RSpec.describe SendUserStatisticsEmailJob, type: :job do
  describe '#perform' do
    before do
      allow(UserMailer).to receive_message_chain(:user_statistics_email, :deliver_now)
    end

    it 'calls UserMailer' do
      described_class.new.perform
      expect(UserMailer).to have_received(:user_statistics_email)
    end
  end
end
