Rails.application.routes.draw do
  resources :products do
    resources :images
    resources :comments
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root "products#index"
end
