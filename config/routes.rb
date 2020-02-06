Rails.application.routes.draw do
  
  devise_for :users
  root to: 'posts#index'
  resources :items,only:[:index, :new, :create, :confirm, :buy] do
    collection do 
      get 'confirm'
      get 'buy'
    end
  end
  # 商品が登録できるようになったらcollectionをmemberに変更

  resources :comments

  resources :images
  resources :brands

end