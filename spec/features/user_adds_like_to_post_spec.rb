require 'rails_helper'

feature 'user adds like to post' do
  let!(:user) { create(:user) }
  let!(:likeable_post) { create(:post) }

  scenario 'successfully', js: true do
    login_as user
    visit post_path(likeable_post)
    click_on(class: 'like-button')
    expect(page).to have_selector('span.like-count', text: '1 like')
    expect(page).to have_selector('a.liked')
  end
end
