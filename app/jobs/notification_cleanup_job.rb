class NotificationCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    @notifications = Notification.where('created_at >= ? AND created_at <= ?', DateTime.now - 60.day, DateTime.now - 30.day)
    @notifications.each do |notification|
      notification.destroy
    end
  end
end
