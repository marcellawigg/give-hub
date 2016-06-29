Rails.application.routes.draw do
  namespace :admin do
    resource :dashboard, only: [:show]
    resources :families, only: [:show, :new, :create, :index, :update]
  end

  resources :users, only: [:new, :create, :edit, :update]

  resources :cart, only: [:index]

  resources :cart_items, only: [:create, :update, :destroy]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: "users#show"

  resources :donations, only: [:index, :show, :new, :create]

  resources :homes, only: [:show]

  root to: "homes#index"

  resources :charities, only: [:index]

  get ':charity_slug', to: 'charities#show', as: :charity

  namespace :charity,  path: ':charity', as: :charity do
    resources :recipients, only: :show
  end

  # resources :categories, only: [:show], path: ""
end
