class Api::V1::ChatsController < ApplicationController
  def create
    new_chat = Chat.find_or_create_by(current_resource_owner.id, params[:user_id])

    if new_chat.id
      render json: new_chat
    else
      render status: 400, json: new_chat.errors.messages
    end
  end
end
