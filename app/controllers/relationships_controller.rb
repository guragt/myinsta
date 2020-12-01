class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :obtain_relationship, only: %i[update destroy]
  before_action :obtain_active_relationships, only: %i[create destroy]

  def create
    relationship = @active_relationships.build(relationship_params)
    @user = relationship.followed
    relationship.save
  end

  def update
    @relationship.active!
  end

  def destroy
    @user = @relationship.followed
    @relationship.destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end

  def obtain_relationship
    @relationship = Relationship.find(params[:id])
  end

  def obtain_active_relationships
    @active_relationships = current_user.active_relationships
  end
end
