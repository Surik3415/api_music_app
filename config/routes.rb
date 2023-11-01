# frozen_string_literal: true

Rails.application.routes.draw do
  resources :friendships
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'ping#index'
  post '/sign_in', to: 'signin#create'
  post '/sign_up', to: 'signup#create'
  delete '/sign_out', to: 'signin#destroy'

  namespace :api do
    namespace :v1 do
      resource :user_profile, only: %i[show update destroy]
      resources :playlists

      get 'friend_requests/:tab', to: 'friend_requests#index',
                                  constraints: {
                                    tab: /#{FriendRequestTabs::ALL.map(&:to_s).join('|')}/
                                  }
    end
  end
end
