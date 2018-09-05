Rails.application.routes.draw do
  resources :products do
    resources :images
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
