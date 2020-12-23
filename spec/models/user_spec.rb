require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:active_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:passive_relationships).dependent(:destroy) }
    it { is_expected.to have_many(:following).through(:active_relationships) }
    it { is_expected.to have_many(:followers).through(:passive_relationships) }
  end

  describe 'Validations' do
    context 'presence validation' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:nickname) }
    end

    context 'length validation' do
      it { is_expected.to validate_length_of(:name).is_at_most(50) }
      it { is_expected.to validate_length_of(:nickname).is_at_most(30) }
    end

    context 'format validation' do
      it { is_expected.to allow_value('*my_nick!*').for(:nickname) }
      it { is_expected.not_to allow_value('my nick').for(:nickname) }
    end

    context 'uniqueness validation' do
      it { is_expected.to validate_uniqueness_of(:nickname) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end

  describe '#following_status' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }

    it 'should retun status not_following' do
      expect(user.following_status_for(other_user)).to eq('not_following')
    end

    it 'should retun status pending' do
      user.following << other_user
      expect(user.following_status_for(other_user)).to eq('pending')
    end

    it 'should retun status active' do
      user.active_relationships.create(followed_id: other_user.id, status: 'active')
      expect(user.following_status_for(other_user)).to eq('active')
    end
  end

  describe '#show_content_for?' do
    let!(:user) { create(:user) }
    let!(:public_user) { create(:user) }
    let!(:private_user) { create(:private_user) }

    it 'should return false' do
      expect(user.show_content_for?(private_user)).to be false
    end

    it 'should return true' do
      user.active_relationships.create(followed_id: private_user.id, status: 'active')
      expect(user.show_content_for?(private_user)).to be true
      expect(user.show_content_for?(public_user)).to be true
    end
  end

  describe '#show_post_for?' do
    let!(:user) { create(:user) }
    let!(:public_user) { create(:user) }
    let!(:private_user) { create(:private_user) }

    it 'should return false' do
      expect(user.show_post_for?(private_user)).to be false
    end

    it 'should return true' do
      user.active_relationships.create(followed_id: private_user.id, status: 'active')
      expect(user.show_post_for?(private_user)).to be true
      expect(user.show_post_for?(public_user)).to be true
      expect(user.show_post_for?(user)).to be true
    end
  end
end
