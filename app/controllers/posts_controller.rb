class PostsController < ApplicationController
  before_action :authenticate_user!

  def new; end

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
end
