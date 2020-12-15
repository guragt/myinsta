require 'rails_helper'

RSpec.describe AdminDashboardsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  context 'user is admin' do
    before { sign_in admin }

    describe 'GET#index' do
      it 'renders index template' do
        get :index
        expect(response).to have_http_status(:success)
        expect(response).to render_template('index')
        expect(assigns(:users)).to include(user)
        expect(assigns(:users)).not_to include(admin)
      end
    end
  end

  context 'user is not admin' do
    before { sign_in user }

    describe 'GET#index' do
      it 'does not render index template' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).not_to render_template('index')
        expect(flash[:warning]).to be_present
      end
    end
  end

  context 'unauthorized user' do
    describe 'GET#index' do
      it 'does not render index template' do
        get :index
        expect(response).to have_http_status(:redirect)
        expect(response).not_to render_template('index')
        expect(flash[:alert]).to be_present
      end
    end
  end
end
