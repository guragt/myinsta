class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show following followers]
  before_action :obtain_active_relationships, only: %i[index show]

  def index
    @users = @q.result.page(params[:page])
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def following
    @relationships = @user.active_relationships.active.page(params[:page])
  end

  def followers
    @relationships = @user.passive_relationships.active.page(params[:page])
  end

  private

  def obtain_user
    @user = User.find(params[:id])
  end

  def obtain_active_relationships
    @active_relationships = current_user.active_relationships
  end
end
