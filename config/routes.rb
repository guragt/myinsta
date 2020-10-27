Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :users, only: %i[show]
  resources :posts, only: %i[new create]
end
