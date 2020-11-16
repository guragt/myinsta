class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_relationship, only: %i[update destroy]

  def create
    @relationship = current_user.active_relationships.build(relationship_params)
    @user = @relationship.followed
    respond_to do |format|
      format.js if @relationship.save
    end
  end

  def update
    @relationship.active!
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    @relationship.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end

  def obtain_relationship
    @relationship = Relationship.find(params[:id])
  end
end
