Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :order_products

  get 'orders/:product_id/add_cart', to: 'orders#add_cart', as: :add_cart
  post 'orders/:product_id/add_to_cart', to: 'orders#add_to_cart', as: :add_to_cart

  post 'orders/:product_id/add_rating', to: 'orders#add_rating', as: :add_rating

  post 'comments/render_comment', to: 'comments#render_comment', as: :render_comment

  post 'orders/:product_id/user_rate', to: 'orders#user_rate', as: :user_rate

  
  resources :orders do
  end
  resources :products do
    resources :images
    resources :comments
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'registrations/update_image', to: 'users/registrations#update_image', as: :update_image
  end

  resources :charges
  get 'charges/new/:amount', to: 'charges#new', as: :new

  root "products#index"
  mount ActionCable.server => '/cable '
end