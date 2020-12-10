require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:second_user) { create(:user, name: 'Johnny Dep', nickname: 'some_nick') }
  let!(:third_user) { create(:user, name: 'Some Name', nickname: '<<jonathan>>') }
  let!(:fourth_user) { create(:user, name: 'Default Name', nickname: 'default_nick') }

  context 'authorized user' do
    before { sign_in user }

    describe 'GET#index' do
      it 'renders index template' do
        get :index, params: { q: { name_or_nickname_cont: 'JO' } }
        expect(assigns(:users)).to include(second_user)
        expect(assigns(:users)).to include(third_user)
        expect(assigns(:users)).not_to include(fourth_user)
      end
    end

    describe 'GET#show' do
      context 'other user' do
        it 'renders show template' do
          get :show, params: { id: second_user.id }
          expect(response).to have_http_status(:success)
          expect(response).to render_template('show')
        end
      end

      context 'current user' do
        it 'does not render current template' do
          get :show, params: { id: user.id }
          expect(response).to redirect_to(current_users_path)
          expect(response).not_to render_template('show')
        end
      end
    end

    describe 'GET#current' do
      it 'renders current template' do
        get :current
        expect(response).to have_http_status(:success)
        expect(response).to render_template('current')
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
    describe 'GET#index' do
      it 'does not render index template' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('index')
      end
    end

    describe 'GET#show' do
      it 'does not render show template' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('show')
      end
    end

    describe 'GET#current' do
      it 'does not render current template' do
        get :current
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('current')
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
