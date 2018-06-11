class ApplicationController < ActionController::API
  before_action :authenticate_uer!

  protect_from_forgery with: :exception
end
