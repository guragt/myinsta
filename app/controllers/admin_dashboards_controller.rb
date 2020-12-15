class AdminDashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.with_deleted.non_admins.page(params[:page])
  end
end
