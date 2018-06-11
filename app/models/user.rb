class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :chats, foreign_key: :sender_id

  scope :everyone_else, ->(user) { all.where.not(id: user.id) }
end
