Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get "/users/:id", to: "users#show"
  get "/create_tweet", to: "tweets#new", as: "tweets"
  post "/create_tweet", to: "tweets#create"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
