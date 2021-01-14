require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#following_status_partial_name' do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }

    it 'should return follow' do
      expect(following_status_partial_name(follower, followed)).to eq('follow')
    end

    it 'should return cancel' do
      follower.following << followed
      expect(following_status_partial_name(follower, followed)).to eq('cancel')
    end

    it 'should return unfollow' do
      follower.active_relationships.create(followed_id: followed.id, status: 'active')
      expect(following_status_partial_name(follower, followed)).to eq('unfollow')
    end
  end

  describe '#relationship_update_partial_name' do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }

    it 'should return confirm_message' do
      relation = follower.active_relationships.create(followed_id: followed.id,
                                                      status: 'active')
      expect(relationship_update_partial_name(relation)).to eq('confirm_message')
    end

    it 'should return decline_message' do
      relation = follower.active_relationships.create(followed_id: followed.id,
                                                      status: 'declined')
      expect(relationship_update_partial_name(relation)).to eq('decline_message')
    end
  end

  describe '#relationship_delete_partial_name' do
    let!(:follower) { create(:user) }
    let!(:followed) { create(:user) }

    it 'should return unfollow_message' do
      allow(helper).to receive(:current_user).and_return(follower)
      relation = follower.active_relationships.create(followed_id: followed.id,
                                                      status: 'active')
      expect(helper.relationship_delete_partial_name(relation)).to eq('unfollow_message')
    end

    it 'should return delete_message' do
      allow(helper).to receive(:current_user).and_return(followed)
      relation = followed.passive_relationships.create(follower_id: follower.id,
                                                       status: 'active')
      expect(helper.relationship_delete_partial_name(relation)).to eq('delete_message')
    end

    it 'should return decline_message' do
      allow(helper).to receive(:current_user).and_return(followed)
      relation = followed.passive_relationships.create(follower_id: follower.id,
                                                       status: 'declined')
      expect(helper.relationship_delete_partial_name(relation)).to eq('unlock_message')
    end
  end

  describe '#likes_count_block' do
    let!(:count_zero) { 0 }
    let!(:count_one) { 1 }
    let!(:count_two) { 2 }

    it 'count greater then 1' do
      expect(likes_count_block(count_two))
        .to eq("<span class=\"like-count\">#{count_two} likes</span>")
    end

    it 'count equal 1' do
      expect(likes_count_block(count_one))
        .to eq("<span class=\"like-count\">#{count_one} like</span>")
    end

    it 'count equal 0' do
      expect(likes_count_block(count_zero)).to be_nil
    end
  end

  describe '#comments_count_for' do
    let!(:post) { create(:post, :with_comments) }

    it 'should return comments count' do
      expect(comments_count_for(post)).to eq(post.comments.count)
    end
  end
end
