require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  let!(:user) { create(:user, :with_following) }
  let!(:followed_user) { create(:user) }

  context 'authorized user' do
    before { sign_in user }

    describe 'POST#create' do
      it 'creates a new relationship' do
        expect do
          post :create, xhr: true,
                        params: { relationship: { followed_id: followed_user.id } }
        end.to change(Relationship, :count).by(1)
      end
    end

    describe 'PUT#update' do
      before do
        put :update, xhr: true, params: { id: user.active_relationships.first }
      end

      it 'updates realtionship status' do
        expect(user.active_relationships.first.status).to eq('active')
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes relationship' do
        expect do
          delete :destroy, xhr: true, params: { id: user.active_relationships.first }
        end.to change(Relationship, :count).by(-1)
      end
    end
  end

  context 'unauthorized user' do
    describe 'POST#create' do
      it 'does not create a new relationship' do
        expect do
          post :create, xhr: true,
                        params: { relationship: { followed_id: followed_user.id } }
        end.not_to change(Relationship, :count)
      end
    end

    describe 'PUT#update' do
      before do
        put :update, xhr: true, params: { id: user.active_relationships.first }
      end

      it 'does not update realtionship status' do
        expect(user.active_relationships.first.status).to_not eq('active')
      end
    end

    describe 'DELETE#destroy' do
      it 'does not delete relationship' do
        expect do
          delete :destroy, xhr: true, params: { id: user.active_relationships.first }
        end.not_to change(Relationship, :count)
      end
    end
  end
end
