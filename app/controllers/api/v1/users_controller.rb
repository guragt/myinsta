module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def index
        @users = if params[:provider].present?
                   if params[:provider] == 'native'
                     User.where(provider: nil)
                   else
                     User.where(provider: params[:provider])
                   end
                 else
                   User.all
                 end
      end

      def show
        @user = User.find(params[:id])
      end
    end
  end
end
