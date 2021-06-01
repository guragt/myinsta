require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let!(:existing_user) { create(:user, provider: 'oktaoauth', uid: '12345') }

  let!(:existing_user_okta_hash) do
    OmniAuth::AuthHash.new({
                             provider: existing_user.provider,
                             uid: existing_user.uid,
                             info: {
                               email: existing_user.email,
                               name: 'Existing User'
                             },
                             extra: {
                               raw_info: {
                                 nickname: 'existing_user'
                               }
                             }
                           })
  end

  let!(:new_valid_user_okta_hash) do
    OmniAuth::AuthHash.new({
                             provider: 'oktaoauth',
                             uid: '12346',
                             info: {
                               email: 'new_user@test.net',
                               name: 'New User'
                             },
                             extra: {
                               raw_info: {
                                 nickname: 'new_user'
                               }
                             }
                           })
  end

  let!(:new_invalid_user_okta_hash) do
    OmniAuth::AuthHash.new({
                             provider: 'oktaoauth',
                             uid: '12347',
                             info: {
                               email: 'new_user@test.net',
                               name: ''
                             },
                             extra: {
                               raw_info: {
                                 nickname: ''
                               }
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

    context 'new valid user' do
      before do
        request.env['omniauth.auth'] = new_valid_user_okta_hash

        get :oktaoauth
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to(root_path)
      end

      it 'should have a current_user' do
        expect(subject.current_user).to_not eq(nil)
      end
    end

    context 'new invalid user' do
      before do
        request.env['omniauth.auth'] = new_invalid_user_okta_hash

        get :oktaoauth
      end

      it 'redirect to root_path' do
        expect(response).to render_template('new')
      end

      it 'should have a current_user' do
        expect(subject.current_user).to eq(nil)
      end
    end
  end
end
