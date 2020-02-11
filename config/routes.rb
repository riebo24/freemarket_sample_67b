Rails.application.routes.draw do

  devise_for :users
  # , controllers: {
  #  registrations: 'users/registrations',
  #  sessions: 'users/sessions',
  #  password: 'users/passwords'
  # }

  devise_scope :user do
    get 'my_page' => 'users/registrations#my_page'
  end

  root to: 'items#index'
  resources :items,only:[:index, :new, :create, :show, :confirm, :buy] do
    collection do
      get 'confirm'
      get 'buy'
    end
  end

  resources :comments
  resources :categorys, only:[:index] 
  resources :images
  resources :brands
  resources :users, only: :show


end