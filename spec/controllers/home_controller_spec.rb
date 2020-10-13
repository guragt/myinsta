require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:user) { create(:user) }

  describe 'GET /index' do
    context 'user is signed_in' do
      before { sign_in user }
      subject { get :index }
      it { is_expected.to have_http_status(:success) }
      it { is_expected.to render_template('index') }
    end

    context 'user is not signed_in' do
      subject { get :index }
      it { is_expected.to have_http_status(:redirect) }
      it { is_expected.not_to render_template('index') }
    end
  end
end
