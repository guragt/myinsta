module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def oktaoauth
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user
      else
        flash[:warning] = t('need_sign_up')
        redirect_to new_user_registration_path
      end
    end
  end
end
