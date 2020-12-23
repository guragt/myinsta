require 'rails_helper'

feature 'user redirected to root after login' do
  let!(:user) { create(:user, password: 'password', password_confirmation: 'password') }

  scenario 'successfully' do
    visit new_user_session_path
    fill_in id: 'user_email', with: user.email
    fill_in id: 'user_password', with: 'password'
    find('input', class: 'btn btn-primary').click

    expect(page).to have_text('Signed in successfully.')
    expect(page).to have_text("Hello #{user.name}")
  end
end
