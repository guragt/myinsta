require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create(:user, :with_comments) }
  let!(:parent) { create(:post) }
  let!(:comment) { create(:comment) }

  context 'authorized user' do
    before { sign_in user }

    describe 'POST#create' do
      context 'with valid params' do
        it 'creates a new comment' do
          expect do
            post :create, xhr: true, params: { comment: { parent_type: parent.class.name,
                                                          parent_id: parent.id,
                                                          body: 'Valid body' } }
          end.to change(Comment, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'does not create a new comment' do
          expect do
            post :create, xhr: true, params: { comment: { parent_type: parent.class.name,
                                                          parent_id: parent.id,
                                                          body: '' } }
          end.not_to change(Comment, :count)
        end
      end
    end

    describe 'DELETE#destroy' do
      it 'deletes a comment' do
        expect do
          delete :destroy, xhr: true, params: { id: user.comments.first.id }
        end.to change(Comment, :count).by(-1)
      end
    end

    describe 'GET#reply' do
      it 'has http status success' do
        get :reply, xhr: true, params: { id: comment.id }
        expect(response).to have_http_status(:success)
        expect(assigns(:parent)).to eq(comment)
      end
    end
  end

  context 'unauthorized user' do
    describe 'POST#create' do
      it 'does not create a new comment' do
        expect do
          post :create, xhr: true, params: { comment: { parent_type: parent.class.name,
                                                          parent_id: parent.id,
                                                          body: 'Valid body' } }
        end.not_to change(Comment, :count)
      end
    end

    describe 'DELETE#destroy' do
      it 'does not delete a comment' do
        expect do
          delete :destroy, xhr: true, params: { id: user.comments.first.id }
        end.not_to change(Comment, :count)
      end
    end

    describe 'GET#reply' do
      it 'does not have http status success' do
        get :reply, xhr: true, params: { id: comment.id }
        expect(response).not_to have_http_status(:success)
        expect(assigns(:parent)).not_to eq(comment)
      end
    end
  end
end