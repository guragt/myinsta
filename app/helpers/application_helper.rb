module ApplicationHelper
  def following_status_partial_name(follower, followed)
    case follower.following_status_for(followed)
    when 'not_following' then 'follow'
    when 'pending' then 'cancel'
    when 'active' then 'unfollow'
    end
  end

  def likes_count_block(likes_count)
    return if likes_count.zero?

    tag.span(t('likes.like_form.like', count: likes_count), class: 'like-count')
  end

  def comments_count_for(parent)
    parent.comments.count
  end

  def show_gallery_of?(user)
    current_user == user ||
      !user.private ||
      current_user.following_status_for(user) == 'active'
  end
end
