module Users
  class PasswordsController < Devise::PasswordsController
    def create
      if User.find_by(email: resource_params['email'], provider: 'oktaoauth')
        redirect_to "#{ENV['OKTA_URL']}/enduser/settings"
      else
        super
      end
    end
  end
end
