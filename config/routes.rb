Rails.application.routes.draw do
  resources :order_products
  post 'order_products/:product_id/add_to_cart_custom', to: 'order_products#add_to_cart_custom', as: :add_to_cart_custom

  post 'orders/:product_id/add_to_cart', to: 'orders#add_to_cart', as: :add_to_cart
  resources :orders do
  end
  resources :products do
    resources :images
    resources :comments
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root "products#index"
end
