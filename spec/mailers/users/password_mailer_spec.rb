require 'rails_helper'

RSpec.describe Users::PasswordMailer, type: :mailer do
  describe 'reset okta password instructions' do
    let!(:user) { create(:user) }
    let!(:mail) { Users::PasswordMailer.reset_okta_password_instructions(user.email) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Reset password instructions')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['myinstaror@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
