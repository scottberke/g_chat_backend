class RemoveReferenceFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_reference :messages, :chat, foriegn_key: true
  end
end
