require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:native_user) { create(:user) }
  let!(:octa_user) { create(:user, provider: 'oktaoauth') }
  let!(:username) { Rails.configuration.username }
  let!(:password) { Rails.configuration.password }
  let!(:token) { instance_double('Doorkeeper::AccessToken', acceptable?: true) }

  context 'authenticated' do
    before do
      allow(controller).to receive(:doorkeeper_token) { token }
    end

    describe 'GET#index' do
      context 'without params' do
        it 'renders index template' do
          get :index, format: :json

          expect(response).to have_http_status(:success)
          expect(response).to render_template('index')
          expect(assigns(:users)).to include(native_user)
          expect(assigns(:users)).to include(octa_user)
        end
      end

      context 'with valid params' do
        it 'renders index template' do
          get :index, params: { provider: 'oktaoauth' }, format: :json

          expect(response).to have_http_status(:success)
          expect(response).to render_template('index')
          expect(assigns(:users)).to include(octa_user)
          expect(assigns(:users)).to_not include(native_user)
        end
      end

      context 'with invalid params' do
        it 'does not render index template' do
          get :index, params: { provider: 'facebook' }, format: :json

          expect(response).to have_http_status(:bad_request)
          expect(response).to_not render_template('index')
        end
      end
    end

    describe 'GET#show' do
      it 'renders show template' do
        get :show, params: { id: native_user.id }, format: :json

        expect(response).to have_http_status(:success)
        expect(response).to render_template('show')
      end
    end
  end

  context 'unauthenticated' do
    describe 'GET#index' do
      it 'does not render index template' do
        get :index, format: :json

        expect(response).to have_http_status(:unauthorized)
        expect(response).to_not render_template('index')
      end
    end

    describe 'GET#show' do
      it 'does not render show template' do
        get :show, params: { id: native_user.id }, format: :json

        expect(response).to have_http_status(:unauthorized)
        expect(response).to_not render_template('show')
      end
    end
  end
end
