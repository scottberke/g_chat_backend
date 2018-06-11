require 'rails_helper'

RSpec.describe Message, type: :model do

  it { is_expected.to respond_to :body }
  it { is_expected.to respond_to :user_id }
  it { is_expected.to respond_to :chat_id }

  describe 'relation to user' do
    let(:message) { Message.new }

    it 'belongs to a sender' do
      expect(message).to belong_to(:user)
    end

    it 'belongs to a recipient' do
      expect(message).to belong_to(:chat)
    end
  end
end
