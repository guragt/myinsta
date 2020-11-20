require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }

  context 'authorized user' do
    before { sign_in user }

    describe 'POST#create' do
      it 'creates a new like' do
        expect do
          post :create, xhr: true,
                        params: { like: { likeable_type: 'Post', likeable_id: post.id } }
        end.to change(Like, :count).by(1)
      end
    end
  end
end
