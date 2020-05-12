Rails.application.routes.draw do
  get 'pages/index'
  devise_for :users
  root to: 'pages#index'
  #home page to access to other area
  resources :user_profiles, except: [:destroy]
  #user_profile should only be deleted if account is no longer exists
  #user_profiles should only be accessible with admin right
  resources :listings
end
