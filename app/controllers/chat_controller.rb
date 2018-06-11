class ChatController < ApplicationController
  def index
    other_users = User.everyone_else(current_user)
    #conversations = Conversations.includes(recipient, messages).find(conversation_ids)
  end
end
