module Users
  class PasswordsController < Devise::PasswordsController
    def create
      if User.find_by(email: resource_params['email'], provider: 'oktaoauth')
        Users::PasswordMailer.reset_okta_password_instructions(resource_params['email'])
                             .deliver_later
        flash[:success] = t('devise.passwords.send_instructions')
        redirect_to new_user_session_path
      else
        super
      end
    end
  end
end
