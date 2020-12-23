require 'rails_helper'

feature 'user add a comment to post' do
  let!(:user) { create(:user) }
  let!(:commentable_post) { create(:post) }

  scenario 'successfully', js: true do
    login_as user
    visit post_path(commentable_post)
    fill_in id: 'comment_body', with: 'Comment to post'
    click_on(class: 'comment-submit')
    expect(page).to have_selector('div.comment-body', text: 'Comment to post')
    expect(page).to have_selector('a.post-nick', text: user.nickname)
  end
end
