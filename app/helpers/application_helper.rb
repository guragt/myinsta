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
end
