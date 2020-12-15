Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :users, only: %i[index show] do
    collection do
      get :current, :declined
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

  get '/dashboard', to: 'admin_dashboards#index'
end
