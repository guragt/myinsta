require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post_valid_params) { attributes_for(:post)  }
  let!(:post_invalid_params) { { description: 'a' * 2001, image: '' } }

  context 'authorized user' do
    before { sign_in user }

    describe 'GET#index' do
      it 'renders index template' do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template('index')
      end
    end

    describe 'POST#create' do
      context 'with valid params' do
        it 'creates a new post' do
          expect do
            post :create, xhr: true, params: { post: post_valid_params }
          end.to change(Post, :count).by(1)
        end

        it 'redirects to root_path' do
          post :create, xhr: true, params: { post: post_valid_params }
          expect(response).to redirect_to(root_path)
          expect(flash[:success]).to be_present
        end
      end

      context 'with invalid params' do
        it 'does not create a new post' do
          expect do
            post :create, xhr: true, params: { post: post_invalid_params }
          end.not_to change(Post, :count)
        end

        it 'does not redirect to root_path' do
          post :create, xhr: true, params: { post: post_invalid_params }
          expect(response).to_not redirect_to(root_path)
          expect(flash[:success]).to_not be_present
        end
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

    describe 'POST#create' do
      it 'does not create a new post' do
        expect do
          post :create, params: { post: post_valid_params }
        end.not_to change(Post, :count)
      end

      it 'does not redirect to root_path' do
        post :create, xhr: true, params: { post: post_valid_params }
        expect(response).not_to redirect_to(root_path)
        expect(flash[:success]).to_not be_present
      end
    end
  end
end
