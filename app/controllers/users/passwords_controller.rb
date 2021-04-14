module Users
  class PasswordsController < Devise::PasswordsController
    def create
      if User.find_by(email: resource_params['email'], provider: 'oktaoauth')
        redirect_to URI.join(Rails.configuration.okta_url, '/enduser/settings').to_s
      else
        super
      end
    end
  end
end
