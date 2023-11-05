# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'ping#index'

  namespace :api do
    namespace :v1 do
      post '/sign_in', to: 'signin#create'
      post '/sign_up', to: 'signup#create'
      delete '/sign_out', to: 'signin#destroy'

      resource :user_profile, only: %i[show update destroy]

      resources :playlists

      resource :playlist_songs, only: %i[create destroy]

      resources :friend_requests, only: %i[create]

      resources :friendships, only: %i[index create destroy]

      get 'friend_requests/:tab', to: 'friend_requests#index',
                                  constraints: {
                                    tab: /#{FriendRequestTabs::ALL.map(&:to_s).join('|')}/
                                  }
    end
  end
end
