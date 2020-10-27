require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post_valid_params) { attributes_for(:post)  }
  let!(:post_invalid_params) { { description: 'a' * 2001, image: '' } }

  describe 'GET#new' do
    context 'user is signed_in' do
      before { sign_in user }
      subject { get :new }
      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('new') }
    end

    context 'user is not signed_in' do
      subject { get :new }
      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('new') }
    end
  end

  describe 'POST#create' do
    before { sign_in user }

    context 'with valid params' do
      it 'create a new post' do
        expect do
          post :create, params: { post: post_valid_params }
        end.to change(Post, :count).by(1)
      end

      it 'redirect to home page' do
        post :create, params: { post: post_valid_params }
        expect(response).to have_http_status(:redirect)
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid params' do
      it 'create a new post' do
        expect do
          post :create, params: { post: post_invalid_params }
        end.not_to change(Post, :count)
      end

      it 'redirect to home page' do
        post :create, params: { post: post_invalid_params }
        expect(response).not_to have_http_status(:redirect)
        expect(flash[:success]).not_to be_present
      end
    end
  end
end
