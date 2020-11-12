class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user

  def show
    @posts = @user.posts.order(created_at: :desc)
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
