Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'


  resources :comments
  resources :items, only: [:index, :new, :create]
  resources :images
  resources :brands

end