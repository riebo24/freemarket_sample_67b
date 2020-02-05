Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :items
  get '/item/confirm', to: 'items#confirm', as: 'confirm_item'
  # get '/item/:id/buy', to: 'items#buy', as: 'item_buy'
end