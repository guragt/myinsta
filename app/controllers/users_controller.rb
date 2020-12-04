class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show following followers]

  def index
    @users = @q.result
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
    @active_relationships = current_user.active_relationships
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  private

  def obtain_user
    @user = User.find(params[:id])
  end
end
