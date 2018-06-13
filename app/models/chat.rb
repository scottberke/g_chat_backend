class Chat < ApplicationRecord
  has_many :messages
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  validates :sender_id, uniqueness: { scope: :recipient_id,
    message: "Can't send yo self a message foo!" }

  def self.connecting_chat(sender_id, recipient_id)
    where(sender_id: sender_id, recipient_id: recipient_id).
      or(where(sender_id: recipient_id, recipient_id: sender_id)).take
  end

  def self.find_or_create_by(sender_id, recipient_id)
    chat = connecting_chat(sender_id, recipient_id)

    chat ? chat : create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def other_user(user)
    user == recipient ? sender : recipient
  end

end
