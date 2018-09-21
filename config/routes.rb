Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :order_products
  get 'orders/:product_id/add_cart', to: 'orders#add_cart', as: :add_cart
  post 'orders/:product_id/add_to_cart', to: 'orders#add_to_cart', as: :add_to_cart

  post 'orders/:product_id/add_rating', to: 'orders#add_rating', as: :add_rating

  post 'comments/render_comment', to: 'comments#render_comment', as: :render_comment
  
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