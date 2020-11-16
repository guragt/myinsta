module ApplicationHelper
  def following_status_partial_name(follower, followed)
    case follower.following_status_for(followed)
      when 'not_following' then 'follow'
      when 'pending' then 'cancel'
      when 'active' then 'unfollow'
    end
  end
end
