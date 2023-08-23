Rails.application.routes.draw do
  root "welcome#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"
  
  get "/users/:id", to: "users#show", as: :dashboard
end
