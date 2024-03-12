Rails.application.routes.draw do
  resources :order_products do
    collection do
      get 'choose'
      get 'update_address'
    end
  end
  resources :orders do
    member do
      post 'pass'
      post 'receive'
    end
  end
  get "/shipping_infos/new_index", to: "shipping_infos#new_index",as:"new_index_shipping_infos"
  post "/shipping_infos/create_index", to: "shipping_infos#create_index",as:"create_index_shipping_infos"
  resources :shipping_infos do
    # collection do
    #  post 'new_index'
    #end
  end
  resources :carts
  resources :favorites
  #root :to => 'products#read'
  get 'products/read', to: 'products#read', as: 'products_read'
  #post 'products/:product_id/addfav', to: 'products#addfav', as: 'addfav_product'
  resources :products do
    member do
      get 'more'
      post 'addfav'
    end
  end
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users do
  end
  #devise_for :users, controllers: { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users,except: [:show,:destroy,:update]
  # Defines the root path route ("/")
  # root "articles#index"
end
