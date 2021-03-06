module ApplicationHelper
  PARTIAL_NAMES = {
    not_following: 'follow',
    pending: 'cancel',
    active: 'unfollow'
  }.freeze

  def following_status_partial_name(follower, followed)
    PARTIAL_NAMES[follower.following_status_for(followed).to_sym]
  end

  def relationship_update_partial_name(relationship)
    case relationship.status
    when 'active' then 'confirm_message'
    when 'declined' then 'decline_message'
    end
  end

  def relationship_delete_partial_name(relationship)
    return 'unfollow_message' if relationship.follower == current_user

    case relationship.status
    when 'active' then 'delete_message'
    when 'declined' then 'unlock_message'
    end
  end

  def likes_count_block(likes_count)
    return if likes_count.zero?

    tag.span(t('likes.like_form.like', count: likes_count), class: 'like-count')
  end

  def comments_count_for(parent)
    parent.comments.count
  end
end
