require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :encrypted_password }

  describe 'relation to messages' do
    it 'has many messages' do
      expect(user).to have_many :messages
    end
  end

  describe 'relation to chats' do
    it 'has many chats' do
      expect(user).to have_many :chats
    end
  end

  describe '.everyone_else' do
    let!(:user_1) { FactoryBot.create(:user) }
    let!(:user_2) { FactoryBot.create(:user) }

    it 'returns the other user' do
      everyone_else = User.everyone_else(user_1)
      expect(everyone_else[0]).to eq user_2
    end

    it 'returns ONLY the other user' do
      everyone_else = User.everyone_else(user_1)
      expect(everyone_else.size).to eq 1
    end
  end
end
