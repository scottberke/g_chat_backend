class Api::V1::MessagesController < ApplicationController
  # def create
  #   chat = Chat.includes(:recipient).find(options.fetch('chat_id'))
  #
  #   message = chat.messages.create(body: options.fetch('body'),
  #                  user_id: current_user.id,
  #                  chat_id: options.fetch('chat_id'))
  #
  #   render json: new_chat
  # end
  #
  # private
  #
  # def message_params
  #   params.permit
  # end
end
