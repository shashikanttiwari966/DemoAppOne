require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount ActionCable.server => "/cable"

  root :to => "users#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :stripe_webhook

  #rozarpay payments
  resources :rozarpay_payments do
    collection do
      post :unsubscription
      post :success
    end
  end
  resources :order_products do
    collection do
      get :success
      get :stripe_payment
      post :create_card
      get :create_checkout
      get :success
      get :cancel
    end
  end

  #stripe payments
  resources :orders
  resources :stripe_payments do
    collection do
      get :success
      get :cancel
      get :refund_payment
      post :subscription
      post :unsubscription
    end
  end

  resources :theater_show_movie
  resources :movieglu

  resources :users
  get 'notifications/index'
  get 'notifications/:id' => "notifications#show", as:"notification"

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  resources :line_items
  delete 'line_items/:id' => "line_items#destroy"
  get 'carts/:id' => "carts#show", as: "cart"
  get 'carts/show_cart' => "carts#show_cart", as: "show_cart"
  delete 'carts/:id' => "carts#destroy"

end
