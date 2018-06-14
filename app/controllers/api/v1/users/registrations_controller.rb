class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :doorkeeper_authorize!

  def create
    build_resource(sign_up_params)
    resource.save

    if resource.persisted?
      if resource.active_for_authentication?
        render json: resource
      else
        expire_data_after_sign_in!
        render json: resource
      end
    else
      clean_up_passwords resource

      set_minimum_password_length

      render json: resource.errors.messages
    end
  end

  private

  def sign_up_params
    params.permit(:username, :password)
  end
end
