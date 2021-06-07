module Api
  module V1
    class ApplicationController < ::ApplicationController
      skip_before_action :set_q
      before_action :doorkeeper_authorize!
    end
  end
end
