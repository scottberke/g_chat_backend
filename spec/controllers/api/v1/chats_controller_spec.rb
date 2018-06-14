require 'rails_helper'

RSpec.describe Api::V1::ChatsController, type: :controller do

  describe "POST #create" do
    let(:sender) { FactoryBot.create(:user) }
    let(:recipient) { FactoryBot.create(:user) }

    let(:token) { double :acceptable? => true }

    before do |example|
      unless example.metadata[:skip_before]
        allow(controller).to receive(:doorkeeper_token) { token }
        allow(controller).to receive(:current_resource_owner) { sender }
      end
    end

    context "unauthorized user" do
      it "returns http success", skip_before: true do
        post :create, params: { user_id: recipient.id }

        expect(response).to have_http_status(401)
      end
    end

    context "with valid params" do
      it "returns http success" do
        post :create, params: { user_id: recipient.id }

        expect(response).to have_http_status(:success)
      end

      it "creates a new chat" do
        expect {
          post :create, params: { user_id: recipient.id }
        }.to change { Chat.count }.by(1)
      end

      it "returns a new chat" do
        post :create, params: { user_id: recipient.id }

        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "returns http success" do
        post :create, params: { user_id: nil }

        expect(response).to have_http_status(400)
      end

      it "doesnt create a new chat" do
        expect {
          post :create, params: { user_id: nil }
        }.to_not change { Chat.count }
      end

      it "returns error" do
        post :create, params: { user_id: nil }

        expect(response.body).to eq({ recipient: ["must exist"] }.to_json)
      end
    end

  end

end
