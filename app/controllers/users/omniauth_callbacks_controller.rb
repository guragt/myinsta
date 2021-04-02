module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
      @user = User.from_omniauth(request.env['omniauth.auth'])
      sign_in_and_redirect @user
    end
  end
end
