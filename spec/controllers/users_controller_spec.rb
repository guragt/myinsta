require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  context 'authorized user' do
    before { sign_in user }

    describe 'GET#show' do
      it 'renders show template' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('show')
      end
    end

    describe 'GET#followers' do
      it 'renders followers template' do
        get :followers, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('followers')
      end
    end

    describe 'GET#following' do
      it 'renders following template' do
        get :following, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('following')
      end
    end
  end

  context 'unauthorized user' do
    describe 'GET#show' do
      it 'does not render show template' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('show')
      end
    end

    describe 'GET#followers' do
      it 'does not render followers template' do
        get :followers, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('followers')
      end
    end

    describe 'GET#following' do
      it 'does not render following template' do
        get :following, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('following')
      end
    end
  end
end
