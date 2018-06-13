class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    # binding.pry
    current_user = User.find(1)
    other_users = User.everyone_else(current_user)

    render json: other_users
  end
end
