require 'rails_helper'

feature 'admin visits admin page' do
  let!(:admin) { create(:admin) }
  let!(:user) { create(:user) }

  scenario 'successfully' do
    login_as admin
    visit admin_users_path
    expect(page.status_code).to eq(200)
    expect(page).to have_text('Registered user')
    expect(page).to have_selector('td', text: user.name)
    expect(page).to have_selector('td', text: user.nickname)
    expect(page).to have_selector('td', text: admin.name)
    expect(page).to have_selector('td', text: admin.nickname)
  end

  scenario 'unsuccessfully' do
    login_as user
    visit admin_users_path
    expect(page.status_code).to eq(403)
  end
end
