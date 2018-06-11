class Chat < ApplicationRecord
  has_many :messages
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  validates :sender_id, uniqueness: { scope: :recipient_id,
    message: "Can't send yourself a message!" }

  def is_sender?(user)
    user == recipient ? True : False
  end

  def is_recipient?(user)
    user == sender ? True : False
  end
  
end
