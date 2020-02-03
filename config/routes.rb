Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'


  resources :comments
  resources :items
  resources :images
  resources :brands

end