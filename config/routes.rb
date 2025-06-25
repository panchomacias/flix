Rails.application.routes.draw do
  resources :genres
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")

  root "movies#index"
  resources :movies do
    resources :reviews, except: [ :show, :edit, :update, :destroy ]
    resources :favorites, only: [ :create, :destroy ]
  end

  resources :users
  get "signup", to: "users#new", as: :signup

  resource :session, only: [ :create, :destroy ]
  get "signin", to: "sessions#new", as: :signin

  get "movies/filter/:filter", to: "movies#index", as: :movies_filter
end
