Rails.application.routes.draw do
  devise_for :users
  get "dashboard/index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "podcasts#search"

  get "/podcasts", to: "podcasts#search"

  resources :podcasts do
    collection do
      get :search  # Keeps your existing search route
    end

    member do
      post :favorite  
      delete :unfavorite
      patch :played
      patch :unplayed
      patch :finished
      patch :unfinished
    end
    
    resources :feedbacks, only: [:create, :edit, :update, :destroy]
  # Nests feedbacks under podcasts
  end

  resources :subscriptions
  get 'favorites', to: 'users#favorites', as: 'user_favorites'
  get 'subscription', to: 'users#subscriptions', as: 'user_subscriptions'
end