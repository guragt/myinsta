module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      before_action :check_provider, only: :index, if: -> { params[:provider].present? }

      def index
        @users = params[:provider].present? ? filtered_users : User.all
      end

      def show
        @user = User.find_by(id: params[:id])
        render json: 'Not Found', status: :not_found unless @user
      end

      private

      def check_provider
        return if params[:provider] == 'native' || params[:provider] == 'oktaoauth'

        render json: 'Bad request', status: :bad_request
      end

      def filtered_users
        params[:provider] == 'native' ? User.native_auth : User.okta_auth
      end
    end
  end
end
