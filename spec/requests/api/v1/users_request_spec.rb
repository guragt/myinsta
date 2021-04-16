require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:native_user) { create(:user) }
  let!(:octa_user) { create(:user, provider: 'oktaoauth') }
  let!(:username) { Rails.configuration.username }
  let!(:password) { Rails.configuration.password }
  let(:json) { JSON.parse(response.body) }
  let!(:headers) do
    { HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials(
      username, password
    ) }
  end

  context 'authenticated user' do
    describe 'GET /api/v1/users' do
      context 'without params' do
        it 'renders index template' do
          get api_v1_users_path(format: :json), headers: headers

          expect(response).to have_http_status(:success)
          expect(response).to render_template('index')
          expect(json.size).to eq(2)
        end
      end

      context 'with valid params' do
        it 'renders index template' do
          get api_v1_users_path(format: :json), headers: headers,
                                                params: { provider: 'oktaoauth' }

          expect(response).to have_http_status(:success)
          expect(response).to render_template('index')
          expect(json.size).to eq(1)
          expect(json[0]['id']).to eq(octa_user.id)
        end
      end

      context 'with invalid params' do
        it 'does not render index template' do
          get api_v1_users_path(format: :json), headers: headers,
                                                params: { provider: 'facebook' }

          expect(response).to have_http_status(:bad_request)
          expect(response).to_not render_template('index')
        end
      end
    end

    describe 'GET /api/v1/user/:id' do
      it 'renders show template' do
        get api_v1_user_path(native_user, format: :json), headers: headers

        expect(response).to have_http_status(:success)
        expect(response).to render_template('show')
        expect(json['id']).to eq(native_user.id)
      end
    end
  end

  context 'unauthenticated user' do
    describe 'GET /api/v1/users' do
      it 'does not render index template' do
        get api_v1_users_path(format: :json)

        expect(response).to have_http_status(:unauthorized)
        expect(response).to_not render_template('index')
      end
    end

    describe 'GET /api/v1/user/:id' do
      it 'does not render show template' do
        get api_v1_user_path(native_user, format: :json)

        expect(response).to have_http_status(:unauthorized)
        expect(response).to_not render_template('show')
      end
    end
  end
end
