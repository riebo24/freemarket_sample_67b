Rails.application.routes.draw do
  
  devise_for :users
  root to: 'posts#index'
  resources :items,only:[:new, :create, :confirm, :buy] do
    collection do
      get 'confirm'
      get 'buy'
    end
  end

  resources :comments
  resources :images
  resources :brands

end