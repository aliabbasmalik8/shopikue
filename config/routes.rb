# frozen_string_literal: true

# Routes
Rails.application.routes.draw do
  resources :carts

  resources :orders

  resources :products do
    resources :images
    resources :comments
  end

  # post 'products/:search_value/search', to: 'products#search', as: :search

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  authenticated do
    root to: 'secret#index', as: :authenticated_root
  end
  post '/rate' => 'rater#create', :as => 'rate'
  get 'orders/:product_id/add_cart', to: 'orders#add_cart', as: :add_cart
  post 'orders/:product_id/add_to_cart', to: 'orders#add_to_cart', as: :add_to_cart

  post 'orders/:product_id/add_rating', to: 'orders#add_rating', as: :add_rating

  post 'comments/render_comment', to: 'comments#render_comment', as: :render_comment

  post 'orders/:product_id/user_rate', to: 'orders#user_rate', as: :user_rate

  post 'orders/:id/ship_order', to: 'orders#ship_order', as: :ship_order

  post '/images/update_user_image', to: 'images#update_user_image', as: :update_user_image
  # charges routes
  get 'payments/new', to: 'payments#new', as: :new_charge
  post 'payments/create', to: 'payments#create', as: :charges

  root 'products#index'
  mount ActionCable.server => '/cable '
end
