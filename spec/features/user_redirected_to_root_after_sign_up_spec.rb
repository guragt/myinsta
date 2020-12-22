require 'rails_helper'

feature 'user redirected to root after sign up' do
  scenario 'successfully' do
    visit new_user_registration_path
    fill_in id: 'user_name', with: 'Valid Name'
    fill_in id: 'user_nickname', with: 'valid_nickname'
    fill_in id: 'user_email', with: 'valid@gmail.com'
    fill_in id: 'user_password', with: 'password'
    fill_in id: 'user_password_confirmation', with: 'password'
    find('input', class: 'btn btn-primary').click

    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(page).to have_text('Hello Valid Name')
  end
end
