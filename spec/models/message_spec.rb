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

  describe "after commit job" do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }
    let(:chat) { FactoryBot.create(:chat, sender_id: sender.id, recipient_id: recipient.id) }

    it "creates a job on create commit" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        Message.create(body: Faker::ChuckNorris.fact, user: sender, chat: chat)
      }.to have_enqueued_job(ChatMessageCreateEventBroadcastJob)
    end
  end
end
