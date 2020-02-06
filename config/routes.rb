Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'


  resources :comments
  resources :items, only: :new
  resources :images
  resources :brands

end