class ChatMessageCreateEventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.chat.sender
    recipient = message.chat.recipient

    broadcast_message(message: message, to_user: sender, from_user: recipient)
    broadcast_message(message: message, to_user: recipient, from_user: sender)
  end

  def broadcast_message(message:, to_user:, from_user:)
    ActionCable.server.broadcast("chat_channel_#{to_user.id}",
                                chat_id: message.chat_id,
                                created_at: message.created_at,
                                body: message.body,
                                user_id: message.user_id,
                                from_user_id: from_user.id,
                                from_username: from_user.username)
  end
end
