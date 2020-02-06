Rails.application.routes.draw do
  devise_for :users, controllers: {
   registrations: 'users/registrations',
   sessions: 'users/sessions',
   password: 'users/passwords'
  }
  
  devise_scope :user do
    get 'my_page' => 'users/registrations#my_page'
  end

  root to: 'posts#index'
  
  resources :comments
  resources :items, only: :new
  resources :images
  resources :brands

end 