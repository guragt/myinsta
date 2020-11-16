Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  resources :users, only: %i[show] do
    member do
      get :following, :followers
    end
  end
  resources :posts, only: %i[show create edit update destroy]
  resources :relationships, only: %i[create update destroy]
end
