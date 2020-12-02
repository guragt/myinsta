require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_most(1000) }
  end

  describe '#parent_post' do
    let!(:post) { create(:post, :with_comments) }
    let!(:comment) { post.comments.first }

    it 'should retun parent post for reply' do
      reply = comment.comments.create(body: 'Valid body', user: post.user)
      expect(reply.parent_post).to eq(post)
    end
  end
end
