require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'Enum' do
    it { is_expected.to define_enum_for(:status).with_values(pending: 0, active: 1) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:follower) }
    it { is_expected.to belong_to(:followed) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:follower_id) }
    it { is_expected.to validate_presence_of(:followed_id) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
