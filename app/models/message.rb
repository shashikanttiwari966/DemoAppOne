class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :admin_user

  def time
  end

  # after_create do
  #   debugger
  #   ActionCable.server.broadcast "chats_channel", self.conversation, self
  #   # ChatsChannel.broadcast_to(self.conversation, self)
  # end
end
