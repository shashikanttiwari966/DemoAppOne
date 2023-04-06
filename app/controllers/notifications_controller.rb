class NotificationsController < ApplicationController
  def index
    @notifications = current_admin_user.notifications.order(created_at: :desc)
    render layout: false
  end

  def show
    @notification = Notification.find_by(id: params[:id])
    @notification.update(read_at: DateTime.now)
  end
end
