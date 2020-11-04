require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user, :with_posts) }
  let!(:post_valid_params) { attributes_for(:post) }
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

    describe 'GET#show' do
      it 'renders show template' do
        get :show, params: { id: user.posts.first }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('show')
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

    describe 'PUT#update' do
      context 'with valid params' do
        before do
          put :update, params: { id: user.posts.first,
                                 post: post_valid_params.merge!(description: 'Valid description') }
        end
        it 'redirects to root_path' do
          expect(response).to redirect_to(root_path)
          expect(flash[:success]).to be_present
        end

        it 'updates post description' do
          expect(user.posts.first.description).to eq(post_valid_params[:description])
        end
      end

      context 'with invalid params' do
        before do
          put :update, params: { id: user.posts.first,
                                 post: post_invalid_params }
        end
        it 'does not redirect to root_path' do
          expect(response).to_not redirect_to(root_path)
          expect(flash[:success]).to_not be_present
        end

        it 'updates post description' do
          expect(user.posts.first.description).to_not eq(post_valid_params[:description])
        end
      end
    end

    describe 'GET#edit' do
      it 'renders edit template' do
        get :edit, params: { id: user.posts.first }
        expect(response).to have_http_status(:success)
        expect(response).to render_template('edit')
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes post' do
        expect do
          delete :destroy, params: { id: user.posts.first }
        end.to change(Post, :count).by(-1)
      end

      it 'redirects to root_path' do
        delete :destroy, params: { id: user.posts.first }
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to be_present
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
        get :show, params: { id: user.posts.first }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('show')
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

    describe 'GET#edit' do
      it 'does not render edit template' do
        get :edit, params: { id: user.posts.first }
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to_not render_template('edit')
      end
    end

    describe 'PUT#update' do
      before do
        put :update, params: { id: user.posts.first,
                               post: post_valid_params.merge!(description: 'Valid description') }
      end

      it 'does not redirect to root_path' do
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:success]).to_not be_present
      end

      it 'does not update post description' do
        expect(user.posts.first.description).not_to eq(post_valid_params[:description])
      end
    end

    describe 'DELETE#destroy' do
      it 'does not delete post' do
        expect do
          delete :destroy, params: { id: user.posts.first }
        end.not_to change(Post, :count)
      end

      it 'does not redirect to root_path' do
        delete :destroy, params: { id: user.posts.first }
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:success]).to_not be_present
      end
    end
  end
end
