class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{current_admin_user.id}_online", "1")
    stream_from("appearances_channel")
    ActionCable.server.broadcast "appearances_channel",
                                 {user_id: current_admin_user.id,
                                 online: true}
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    redis.del("user_#{current_admin_user.id}_online")
    ActionCable.server.broadcast "appearances_channel",
                                 { user_id: current_admin_user.id,
                                 online: false}
  end

  private

  def redis
    Redis.new
  end
end
