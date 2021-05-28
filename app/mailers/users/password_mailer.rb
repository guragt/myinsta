module Users
  class PasswordMailer < ApplicationMailer
    def reset_okta_password_instructions(email)
      @email = email

      mail(to: @email, subject: t('.subject'))
    end
  end
end
