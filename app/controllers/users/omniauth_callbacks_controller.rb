module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user
      else
        @user.save(validate: false)
        sign_in @user
        redirect_to edit_profile_users_path
      end
    end
  end
end
