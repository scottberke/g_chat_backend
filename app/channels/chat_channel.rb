class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{current_user.id}"
  end

  def unsubscribe
    stop_all_streams
  end

  def create(options)
    chat = Chat.includes(:recipient).find(options.fetch('chat_id'))

    message = chat.messages.create(body: options.fetch('body'),
                   user_id: current_user.id,
                   chat_id: options.fetch('chat_id'))
  end
end
