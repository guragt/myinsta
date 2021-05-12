class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_user, only: %i[show following followers]
  before_action :obtain_current_user, only: %i[edit update]
  before_action :obtain_active_relationships, only: %i[index show]

  def index
    @users = @q.result.page(params[:page])
  end

  def show
    redirect_to current_users_path if @user == current_user
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t('.updated')
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def current
    @posts = current_user.posts.order(created_at: :desc)
  end

  def declined
    @relationships = current_user.passive_relationships.declined.page(params[:page])
  end

  def following
    @relationships = @user.active_relationships.active
    render json: @relationships.to_json(include: [:followed])
  end

  def followers
    @relationships = @user.passive_relationships.active
    render json: @relationships.to_json(include: [:follower])
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :private, :avatar,
                                 :avatar_cache, :remove_avatar)
  end

  def obtain_user
    @user = User.find(params[:id])
  end

  def obtain_current_user
    @user = current_user
  end

  def obtain_active_relationships
    @active_relationships = current_user.active_relationships
  end
end
