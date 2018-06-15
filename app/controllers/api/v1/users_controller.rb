class Api::V1::UsersController < ApplicationController
  def index
    other_users = User.everyone_else(current_resource_owner)

    render json: other_users
  end
end
