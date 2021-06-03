class UsersController < ApplicationController
  before_action :authenticate_user!, except: :create
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

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in_and_redirect @user
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = success_update_message
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
    params.require(:user).permit(:name, :nickname, :email, :password, :provider, :uid,
                                 :private, :avatar, :avatar_cache, :remove_avatar)
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

  def success_update_message
    message = t('.updated')
    if @user.private_previously_changed?
      message << ' ' << if @user.private_previous_change[1]
                          t('.private')
                        else
                          t('.public')
                        end
    end
    message
  end
end
