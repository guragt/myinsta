require 'rails_helper'

feature 'user begins to follow other user' do
  let!(:follower) { create(:user) }
  let!(:followed) { create(:user) }

  scenario 'successfully', js: true do
    login_as follower
    visit user_path(followed)
    click_on 'Follow'
    expect(page).to have_selector('a.btn-default', text: 'Unfollow')
  end
end
