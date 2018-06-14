class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :chats, foreign_key: :sender_id

  scope :everyone_else, ->(user) { all.where.not(id: user.id) }

  # Silly me for using 'username' instead of 'email', thus requiring these two:
  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
