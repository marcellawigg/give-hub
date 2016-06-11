Rails.application.routes.draw do
  namespace :admin do
    resource :dashboard, only: [:show]
  end

  resources :families, only: [:index, :show]

  resources :users, only: [:new, :create]

  resources :cart, only: [:index] do
    resources :cart_items, only: [:create, :update, :destroy]
  end 

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: "users#show"

  resources :donations, only: [:index, :show]


  root to: "families#index"

  resources :categories, only: [:show], path: ""
end
