class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:like][:likeable_id])
    @like = @post.likes.build(like_params)
    @like.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.likeable
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def like_params
    params.require(:like).permit.merge(user_id: current_user.id)
  end
end
