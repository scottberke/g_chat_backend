class RenameConversationInMessageToChat < ActiveRecord::Migration[5.1]
  def change
    rename_column :messages, :conversation_id, :chat_id
  end
end
