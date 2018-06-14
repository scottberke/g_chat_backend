class AddReferenceToChatInMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :chat
  end
end
