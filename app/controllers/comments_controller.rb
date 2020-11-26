class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  def reply
    @parent = Comment.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_type, :parent_id)
  end
end
