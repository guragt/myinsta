require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:second_user) { create(:user, name: 'Johnny Dep', nickname: 'some_nick') }
  let!(:third_user) { create(:user, name: 'Some Name', nickname: '<<jonathan>>') }
  let!(:fourth_user) { create(:user, name: 'Default Name', nickname: 'default_nick') }
  let!(:valid_params) { attributes_for(:user) }
  let!(:active_relationship) do
    create(:relationship, follower: user, followed: second_user, status: 'active')
  end
  let!(:passive_relationship) do
    create(:relationship, follower: third_user, followed: user, status: 'active')
  end
  let(:json) { JSON.parse(response.body) }

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

    describe 'GET#edit' do
      it 'renders edit template' do
        get :edit
        expect(response).to have_http_status(:success)
        expect(response).to render_template('edit')
      end
    end

    describe 'PATCH#update' do
      context 'with valid params' do
        before do
          patch :update, params: { user: valid_params }
        end
        it 'redirects to root_path' do
          expect(response).to redirect_to(root_path)
          expect(flash[:success]).to be_present
        end

        it 'updates user name' do
          user.reload
          expect(user.name).to eq(valid_params[:name])
        end
      end

      context 'with invalid params' do
        before do
          patch :update, params: { user: valid_params.merge!(nickname: '') }
        end
        it 'does not redirect to root_path' do
          expect(response).to_not redirect_to(root_path)
          expect(flash[:success]).to_not be_present
        end

        it 'does not update user nickname' do
          expect(user.nickname).to_not eq(valid_params[:nickname])
        end
      end

      context 'with email of other user' do
        before do
          patch :update, params: { user: valid_params.merge!(email: second_user.email) }
        end
        it 'does not redirect to root_path' do
          expect(response).to_not redirect_to(root_path)
          expect(flash[:success]).to_not be_present
        end

        it 'does not update user email' do
          expect(user.email).to_not eq(valid_params[:email])
        end
      end
    end

    describe 'GET#declined' do
      it 'renders declined template' do
        get :declined
        expect(response).to have_http_status(:success)
        expect(response).to render_template('declined')
      end
    end

    describe 'GET#followers' do
      it 'returns passive relationship' do
        get :followers, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(json.size).to eq(1)
        expect(json[0]['id']).to eq(passive_relationship.id)
      end
    end

    describe 'GET#following' do
      it 'returns active relationship' do
        get :following, params: { id: user.id }
        expect(response).to have_http_status(:success)
        expect(json.size).to eq(1)
        expect(json[0]['id']).to eq(active_relationship.id)
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

    describe 'GET#edit' do
      it 'does not render edit template' do
        get :edit
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('edit')
      end
    end

    describe 'PATCH#update' do
      before do
        patch :update, params: { user: valid_params }
      end

      it 'does not redirect to root_path' do
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:success]).to_not be_present
      end
    end

    describe 'GET#declined' do
      it 'does not render declined template' do
        get :declined
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('declined')
      end
    end

    describe 'GET#followers' do
      it 'redirects to login page' do
        get :followers, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET#following' do
      it 'redirects to login page' do
        get :following, params: { id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
