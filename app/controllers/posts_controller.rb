class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :obtain_post, only: %i[show]

  def index
    if signed_in?
      @posts = current_user.posts.order(created_at: :desc)
    else
      redirect_to new_user_session_path
    end
  end

  def show; end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        flash[:success] = t('.notice')
        format.js { redirect_to root_path }
      else
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :image_cache, :commentable)
  end

  def obtain_post
    @post = Post.find(params[:id])
  end
end
