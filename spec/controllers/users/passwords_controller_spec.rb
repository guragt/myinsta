require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  let!(:native_user) { create(:user) }
  let!(:okta_user) { create(:user, provider: 'oktaoauth', uid: '12345') }

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'POST#create' do
    context 'native user' do
      it 'redirects to log in path' do
        post :create, params: { user: { email: native_user.email } }

        expect(response).to redirect_to(new_user_session_path)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries[0].to).to include(native_user.email)
      end
    end

    context 'okta user' do
      before do
        allow(Rails.configuration).to receive(:okta_url).and_return('http://dev-90106890.okta.com')
      end

      it 'redirects to log in path' do
        post :create, params: { user: { email: okta_user.email } }

        expect(response).to redirect_to(URI.join(Rails.configuration.okta_url,
                                                 '/enduser/settings').to_s)
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end
end
