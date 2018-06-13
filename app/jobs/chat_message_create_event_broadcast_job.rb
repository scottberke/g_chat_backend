class ChatMessageCreateEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast('chat_channel',
                                  chat_id: message.chat_id,
                                  created_at: message.created_at,
                                  body: message.body)
  end
end
