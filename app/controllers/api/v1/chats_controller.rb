class Api::V1::ChatsController < ApplicationController
  def create
    chat = Chat.find_or_create_by()
  end
end
