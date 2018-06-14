Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications
  end

  namespace :api do
    namespace :v1 do
      get 'users/index'

      resources :chats, only: [:create] do
        resources :messages, only: [:create]
      end

      devise_for :users, controllers: {
        registrations: 'api/v1/users/registrations',
      }, skip: [:sessions, :password]

    end
  end

  # devise_for :users

  # root 'chat#index'

  mount ActionCable.server => '/cable'
end
