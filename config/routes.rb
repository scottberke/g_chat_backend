Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/index'
      resources :chats, only: [:create]
    end
  end

  devise_for :users

  # root 'chat#index'

  mount ActionCable.server => '/cable'
end
