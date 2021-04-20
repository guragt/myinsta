require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'posts#index'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    passwords: 'users/passwords' }

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

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
    end
  end
end
