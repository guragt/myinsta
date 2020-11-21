require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:user, :with_likes) }
  let!(:likeable) { create(:post) }

  context 'authorized user' do
    before { sign_in user }

    describe 'POST#create' do
      it 'creates a new like' do
        expect do
          post :create, xhr: true, params: { like: { likeable_type: 'Post',
                                                     likeable_id: likeable.id } }
        end.to change(Like, :count).by(1)
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes like' do
        expect do
          delete :destroy, xhr: true, params: { id: user.likes.first.id }
        end.to change(Like, :count).by(-1)
      end
    end
  end

  context 'unauthorized user' do
    describe 'POST#create' do
      it 'does not create a new like' do
        expect do
          post :create, xhr: true, params: { like: { likeable_type: 'Post',
                                                     likeable_id: likeable.id } }
        end.not_to change(Like, :count)
      end
    end

    describe 'DELETE#destroy' do
      it 'does not delete like' do
        expect do
          delete :destroy, xhr: true, params: { id: user.likes.first.id }
        end.not_to change(Like, :count)
      end
    end
  end
end
