require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'user_statistics_email' do
    let!(:mail) { UserMailer.user_statistics_email }
    let!(:report_period) { 1.week.ago.all_week }
    let!(:admin) { create(:admin) }
    let!(:user) { create(:user) }
    let!(:new_user) { create(:user, created_at: 7.days.ago) }
    let!(:deleted_user) { create(:user, deleted_at: 7.days.ago) }

    it 'renders the headers' do
      expect(mail.subject).to eq("User's statistics")
      expect(mail.to).to eq([admin.email])
      expect(mail.from).to eq(['myinstaror@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(report_period.begin.strftime('%d.%m.%Y'))
      expect(mail.body.encoded).to match(report_period.end.strftime('%d.%m.%Y'))
      expect(mail.body.encoded).to match('Total users count: 3')
      expect(mail.body.encoded).to match('New users count: 1')
      expect(mail.body.encoded).to match('Deleted users count: 1')
    end
  end
end
