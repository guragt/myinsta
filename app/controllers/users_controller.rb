class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show following followers]

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

  def search
    if params[:q].blank?
      @users = User.all      
    else
      @users = User.search(params)
    end
  end

  private

  def obtain_user
    @user = User.find(params[:id])
  end
end
