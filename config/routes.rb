Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'
  resources :tweets

  get '/:username', to: 'users#show', as: 'user'

  scope ':username' do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
  end

  get 'searching_for', to: 'users#searching_for'
  post 'searching_for', to: 'users#searching_for'
  
  resources :relationships

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
