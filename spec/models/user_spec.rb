require 'rails_helper'

RSpec.describe User, type: :model do
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
    end
  end
end
