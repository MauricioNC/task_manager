Rails.application.routes.draw do
  root "tasks#index"

  resources :tasks
  resources :users

  get "/login", to: "sessions#login"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
