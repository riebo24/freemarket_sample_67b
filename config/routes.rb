Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :items do
    member do
      get 'confirm'
      get 'buy'
    end
  end
end