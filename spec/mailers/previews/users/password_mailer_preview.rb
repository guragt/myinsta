module Users
  class PasswordMailerPreview < ActionMailer::Preview
    def reset_okta_password_instructions
      Users::PasswordMailer.reset_okta_password_instructions(User.first.email)
    end
  end
end
