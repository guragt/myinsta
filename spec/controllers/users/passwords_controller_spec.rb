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
      end
    end

    context 'okta user' do
      it 'redirects to log in path' do
        post :create, params: { user: { email: okta_user.email } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
