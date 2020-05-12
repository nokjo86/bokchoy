Rails.application.routes.draw do
  get 'pages/index'
  devise_for :users
  root to: 'pages#index'
  #home page to access to other area
  get 'profile/user/:id', to: 'profiles#show', as: 'profile'
  get 'profile/edit', to: 'profiles#edit'
  put 'profile', to: 'profiles#update'
  patch 'profile', to: 'profiles#update'
  match 'profile/user/:id' => 'profiles#update', via: :patch

  #user_profile should only be deleted if account is no longer exists
  resources :listings
end
