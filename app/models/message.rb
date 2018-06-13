class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_create_commit do
    ChatMessageCreateEventBroadcastJob.perform_later(self)
  end 
end
