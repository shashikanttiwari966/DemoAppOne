module ApplicationHelper

  def online_status(user)
    content_tag :div, "",id: "user-#{user.id} ",
                class: "online_status #{user.online? ? 'online' : 'offline'}"
  end

  def notification_time(notification)
    if notification.created_at.day == DateTime.now.day
      notification.created_at.strftime("%H:%M")
    elsif notification.created_at.day == (DateTime.now - 1.day).day
      "Yesterday"
    else
      "#{time_ago_in_words(notification.created_at)} ago"
    end
  end

  def message_time(conversation)
    message = conversation.messages&.last
    if message.present?
      if message.created_at.day == DateTime.now.day
        message.created_at.strftime("%H:%M")
      elsif message.created_at.day == (DateTime.now - 1.day).day
        "Yesterday"
      else
        "#{time_ago_in_words(message.created_at)} ago"
      end
    else
      message = "0sec"
    end
  end

  def get_product_sizings(product)
    sizings = []
    product.product_sizings.each do |size|
      sizings << ProductSize.find_by_id(size.product_size_id).size
    end
    sizings.join(",")
  end

  def last_message(conversation)
    message = conversation.messages.present? ? conversation.messages.last.body : "No any message on there!"
    # time = notification_time(conversation.messages.last)
    # return message, time
  end

  def get_friend_user(conversation, user_id)
    user_id.eql?(conversation.friend_id) ? AdminUser.find(conversation.admin_user_id) : AdminUser.find(conversation.friend_id)
  end


end
