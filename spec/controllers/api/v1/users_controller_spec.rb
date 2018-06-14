require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user_1) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }

  let(:token) { double :acceptable? => true }

  before do |example|
    unless example.metadata[:skip_before]
      allow(controller).to receive(:doorkeeper_token) { token }
      allow(controller).to receive(:current_resource_owner) { user_1 }
    end
  end

  context "unauthorized user" do
    it "returns http success", skip_before: true do
      get :index

      expect(response).to have_http_status(401)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
    end

    it "returns only other user" do
      get :index

      paresed_response = JSON.parse(response.body)
      expect(paresed_response.count).to eq 1
    end

    it "returns other users" do
      get :index

      paresed_response = JSON.parse(response.body)
      expect(paresed_response.first["username"]).to eq user_2.username
    end
  end

end
