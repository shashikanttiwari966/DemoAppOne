Rails.application.routes.draw do
  root :to => "users#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :stripe_webhook

  #rozarpay payments
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
  resources :stripe_payments do
    collection do
      get :success
      get :cancel
      get :refund_payment
      post :subscription
      post :unsubscription
    end
  end

  resources :users
end
