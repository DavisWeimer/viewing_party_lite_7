# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/users/:id', to: 'users#show', as: :dashboard
  get '/users/:id/discover', to: 'discover#index', as: :discover

  get '/users/:id/movies', to: 'movies#index', as: :movies
  get '/users/:id/movies/:movie_id', to: 'movies#show', as: :movie

  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'parties#new', as: :new_party
  post '/users/:user_id/movies/:movie_id/viewing-party', to: 'parties#create', as: :create_party

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"
end
