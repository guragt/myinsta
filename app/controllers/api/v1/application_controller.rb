module Api
  module V1
    class ApplicationController < ::ApplicationController
      skip_before_action :set_q
      before_action :authentication_check

      private

      def authentication_check
        authenticate_or_request_with_http_basic do |user, password|
          user == Rails.configuration.username && password == Rails.configuration.password
        end
      end
    end
  end
end
