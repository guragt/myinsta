require 'rails_helper'

feature 'user visit profile page' do
  let!(:user) { create(:user) }

  before { login_as user }

  scenario 'successfully' do
    visit user_path(user)
    expect(page.status_code).to eq(200)
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.nickname)
  end
end
