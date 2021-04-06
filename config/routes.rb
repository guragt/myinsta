Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: %i[index show] do
    collection do
      get :current, :declined
      get :edit_profile, to: 'users#edit'
      patch :update_profile, to: 'users#update'
    end

    member do
      get :following, :followers
    end
  end

  resources :posts, only: %i[show create edit update destroy]
  resources :relationships, only: %i[create update destroy], defaults: { format: :js }
  resources :likes, only: %i[create destroy], defaults: { format: :js }

  resources :comments, only: %i[create destroy], defaults: { format: :js } do
    member do
      get :reply
    end
  end

  namespace :admin do
    resources :users, only: :index
  end
end
