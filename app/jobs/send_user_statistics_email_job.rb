class SendUserStatisticsEmailJob < ApplicationJob
  queue_as :mailers

  def perform
    UserMailer.user_statistics_email.deliver_now
  end
end
