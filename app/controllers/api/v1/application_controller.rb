module Api
  module V1
    class ApplicationController < ::ApplicationController
      skip_before_action :set_q
      before_action :doorkeeper_authorize!

      private

      def doorkeeper_unauthorized_render_options(error: nil)
        { json: t('.not_authorized') }
      end
    end
  end
end
