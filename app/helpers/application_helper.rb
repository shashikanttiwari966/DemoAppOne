module ApplicationHelper

  def notification_time(notification)
    if notification.created_at.day == DateTime.now.day
      notification.created_at.strftime("%H:%M")
    elsif notification.created_at.day == (DateTime.now - 1.day).day
      "Yesterday"
    else
      "#{time_ago_in_words(notification.created_at)} ago"
    end
  end
end
