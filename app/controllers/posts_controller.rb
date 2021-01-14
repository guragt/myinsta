class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :obtain_post, only: %i[show edit update destroy]
  before_action :check_user, only: %i[edit update destroy]

  def index
    return redirect_to new_user_session_path unless signed_in?

    @posts = current_user.feed
  end

  def show
    user = @post.user
    redirect_to user unless current_user.show_post_for?(user)
  end

  def create
    @new_post = current_user.posts.build(post_params)
    respond_to do |format|
      if @new_post.save
        flash[:success] = t('.notice')
        format.js { redirect_to root_path }
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = t('.updated')
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = t('.destroyed')
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :image_cache, :commentable)
  end

  def obtain_post
    @post = Post.find(params[:id])
  end

  def check_user
    return if @post.user == current_user

    flash[:warning] = t('.no_permission')
    redirect_to root_path
  end
end
