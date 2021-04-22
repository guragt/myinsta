class UserMailer < ApplicationMailer
  def user_statistics_email
    @report_period = 1.week.ago.all_week

    @total_users_count = User.all.count
    @new_users_count = User.with_deleted.where(created_at: @report_period).count
    @deleted_users_count = User.with_deleted.where(deleted_at: @report_period).count

    @admins_email = Administrator.all.pluck(:email)

    mail(to: @admins_email, subject: t('.subject'))
  end
end
