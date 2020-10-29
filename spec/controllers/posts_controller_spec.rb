require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post_valid_params) { attributes_for(:post)  }
  let!(:post_invalid_params) { { description: 'a' * 2001, image: '' } }

  context 'authorized user' do
    before { sign_in user }

    describe 'GET#new' do
      subject { get :new }
      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('new') }
    end

    describe 'POST#create' do
      context 'with valid params' do
        it 'create a new post' do
          expect do
            post :create, params: { post: post_valid_params }
          end.to change(Post, :count).by(1)
          expect(response).to have_http_status(:redirect)
          expect(flash[:success]).to be_present
        end
      end

      context 'with invalid params' do
        it 'does not create a new post' do
          expect do
            post :create, params: { post: post_invalid_params }
          end.not_to change(Post, :count)
          expect(response).not_to have_http_status(:redirect)
          expect(flash[:success]).not_to be_present
        end
      end
    end
  end

  context 'unauthorized user' do
    describe 'GET#new' do
      subject { get :new }
      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('new') }
    end

    describe 'POST#create' do
      it 'does not create a new post' do
        expect do
          post :create, params: { post: post_valid_params }
        end.not_to change(Post, :count)
        expect(flash[:success]).not_to be_present
      end
    end
  end
end
