require 'rails_helper'

RSpec.describe Chat, type: :model do
  let(:chat) { Chat.new }

  it { is_expected.to respond_to :recipient_id }
  it { is_expected.to respond_to :sender_id }

  describe 'relation to messages' do
    it 'has many messages' do
      expect(chat).to have_many :messages
    end
  end

  describe 'relation to user' do
    it 'belongs to a sender' do
      expect(chat).to belong_to(:sender).class_name('User')
    end

    it 'belongs to a recipient' do
      expect(chat).to belong_to(:recipient).class_name('User')
    end

    it 'has a unique sender and recipient' do
      expect(chat).to validate_uniqueness_of(:sender_id).
        scoped_to(:recipient_id).
        with_message("Can't send yourself a message!")
    end
  end

  describe 'recipient/sender methods' do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }
    let!(:chat) { FactoryBot.create(:chat, sender_id: sender.id, recipient_id: recipient.id)}

    describe '#other_user' do
      it "returns recipient when passed sender" do
        expect(chat.other_user(sender)).to eq recipient
      end

      it "returns sender when passed recipient" do
        expect(chat.other_user(recipient)).to eq sender
      end

    end

    describe '.connecting_chat' do
      it 'returns the correct chat connecting the two users' do
        expect(Chat.connecting_chat(sender.id, recipient.id)).to eq chat
      end

      it 'returns correct chat regardless of sender/recipient arg order' do
        expect(Chat.connecting_chat(recipient.id, sender.id)).to eq chat
      end
    end

    describe '.find_or_create_by' do
      let(:new_sender) { FactoryBot.create(:user) }

      it 'creates a chat when none exists' do
        expect{ Chat.find_or_create_by(new_sender.id, recipient.id) }.to \
          change { Chat.count }.by(1)
      end

      it 'returns a chat when one already exists' do
        expect{ Chat.find_or_create_by(sender.id, recipient.id) }.to_not \
          change { Chat.count }

        expect(Chat.find_or_create_by(sender.id, recipient.id)).to eq chat
      end

      it 'doesnt create a chat when a invalid user_id is provided' do
        invalid_id = new_sender.id + 1

        expect{ Chat.find_or_create_by(invalid_id, recipient.id) }.to_not \
          change { Chat.count }
      end
    end
  end
end
