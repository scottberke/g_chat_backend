class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_channel'
  end

  def unsubscribe
  end

  def create(options)
    Message.create(body: options.fetch('body'),
                   user_id: options.fetch('user_id'),
                   chat_id: options.fetch('chat_id'))
  end
end
