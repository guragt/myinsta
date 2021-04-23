# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def user_statistics_email
    UserMailer.user_statistics_email
  end
end
