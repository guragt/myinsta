module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_authorization

    def index
      @users = User.with_deleted.page(params[:page])
    end

    private

    def check_authorization
      return head(:forbidden) unless current_user.admin?
    end
  end
end
