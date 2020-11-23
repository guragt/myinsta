require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to validate_length_of(:description).is_at_most(2000) }
  end
end
