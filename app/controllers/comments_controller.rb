class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save if @comment.parent_post.commentable?
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

  def reply
    @parent = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_type, :parent_id)
  end
end
