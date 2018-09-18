Rails.application.routes.draw do
  resources :order_products
  
  get 'orders/:product_id/add_cart', to: 'orders#add_cart', as: :add_cart

  post 'orders/:product_id/add_to_cart', to: 'orders#add_to_cart', as: :add_to_cart
 
  devise_scope :user do
    get 'current_user', to: 'users/registrations#current_user'
  end

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

  mount ActionCable.server => '/cable '

end