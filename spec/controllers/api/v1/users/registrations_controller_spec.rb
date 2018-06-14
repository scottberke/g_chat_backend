require 'rails_helper'

RSpec.describe Api::V1::Users::RegistrationsController, type: :controller do


  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        @request.env['devise.mapping'] = Devise.mappings[:api_v1_user]
        expect {
          post :create, params: { username: Faker::Internet.user_name, password: '123456' }
        }.to change { User.count }.by(1)
      end
    end

    context "with invalid params" do
      it "doesnt not create a new user" do
        @request.env['devise.mapping'] = Devise.mappings[:api_v1_user]
        expect {
          post :create, params: { username: Faker::Internet.user_name, password: '' }
        }.to_not change { User.count }
      end
    end

  end

end
