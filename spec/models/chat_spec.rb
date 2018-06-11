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

  describe '#is_sender?' do
    it "returns true when is sender"
    it "returns false when isn't sender"
  end

  describe '#is_recipient?' do
    it "returns true when is recipient"
    it "returns false when isn't recipient"
  end
end
