require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET /show' do
    context 'user is signed_in' do
      before { sign_in user }
      subject { get :show, params: { id: user.id } }
      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('show') }
    end

    context 'user is not signed_in' do
      subject { get :show, params: { id: user.id } }
      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('show') }
    end
  end
end
