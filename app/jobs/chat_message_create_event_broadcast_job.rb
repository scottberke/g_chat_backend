class ChatMessageCreateEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.chat.sender
    recipient = message.chat.recipient

    broadcast_message(message: message, to_user: sender)
    broadcast_message(message: message, to_user: recipient)
  end

  def broadcast_message(message:, to_user:)
    ActionCable.server.broadcast("chat_channel_#{to_user.id}",
                                chat_id: message.chat_id,
                                created_at: message.created_at,
                                body: message.body,
                                user_id: message.user_id)
  end
end
