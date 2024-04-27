class ChatsChannel < ApplicationCable::Channel
  rescue_from 'MyError', with: :deliver_error_message

  def subscribed
    # stream_from "some_channel"
    # stop_all_streams
    stream_from "chats_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("chats_channel", data)
  end

  private

  def deliver_error_message(e)
    # broadcast_to(...)
  end
end
