class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @relationship = current_user.active_relationships.build(relationship_params)
    @user = @relationship.followed
    respond_to do |format|
      if @relationship.save
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @user = @relationship.followed
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:follower_id, :followed_id, :status)
  end
end
