require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let!(:existing_user) { create(:user, provider: 'oktaoauth', uid: '12345') }
  let!(:existing_user_okta_hash) do
    OmniAuth::AuthHash.new({
                             provider: existing_user.provider,
                             uid: existing_user.uid,
                             info: {
                               email: existing_user.email
                             }
                           })
  end
  let!(:new_user_okta_hash) do
    OmniAuth::AuthHash.new({
                             provider: 'oktaoauth',
                             uid: '67890',
                             info: {
                               email: 'new_user@test.net'
                             }
                           })
  end

  describe 'GET#oktaoauth' do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    context 'existing user' do
      before do
        request.env['omniauth.auth'] = existing_user_okta_hash

        get :oktaoauth
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'should have a current_user' do
        expect(subject.current_user).to eq(existing_user)
      end
    end

    context 'new user' do
      before do
        request.env['omniauth.auth'] = new_user_okta_hash

        get :oktaoauth
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to(edit_profile_users_path)
      end

      it 'should have a current_user' do
        expect(subject.current_user).to_not eq(nil)
      end
    end
  end
end
