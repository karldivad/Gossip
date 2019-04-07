Rails.application.routes.draw do
  get 'search' => 'search#index'
  devise_for :users
  get 'home/index'

  resources :users, only: [:show, :edit, :update]
  resources :posts, only: [:show, :new, :create, :destroy]
  
  root to: 'home#index'
end
