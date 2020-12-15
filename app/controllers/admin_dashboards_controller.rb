class AdminDashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @users = User.with_deleted.page(params[:page])
    else
      flash[:warning] = t('.not_authorized')
      redirect_back(fallback_location: root_path)
    end
  end
end
