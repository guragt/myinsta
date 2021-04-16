module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      before_action :check_provider, only: :index, if: -> { params[:provider].present? }
      before_action :obtain_users, only: :index

      def index; end

      def show
        @user = User.find(params[:id])
      end

      private

      def check_provider
        return if params[:provider] == 'native' || params[:provider] == 'oktaoauth'

        render json: t('.bad_request'), status: :bad_request
      end

      def obtain_users
        @users = if params[:provider].present?
                   if params[:provider] == 'native'
                     User.native_auth
                   else
                     User.okta_auth
                   end
                 else
                   User.all
                 end
      end
    end
  end
end
