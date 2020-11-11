class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_relationship, only: %i[update destroy]

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

  def update
    @relationship.update(relationship_params)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def destroy
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

  def obtain_relationship
    @relationship = Relationship.find(params[:id])
  end
end
