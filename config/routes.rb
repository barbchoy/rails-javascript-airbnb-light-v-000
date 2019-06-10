Rails.application.routes.draw do

  # get 'reviews/show'
  # get 'reviews/index'
  # get 'reviews/new'
  # get 'reviews/edit'
  # get 'reviews/delete'
  # get 'stays/create'
  # get 'houses/index'
  # get 'houses/create'
  # get 'houses/new'
  # get 'houses/edit'
  # get 'houses/show'
  # get 'houses/update'
  # get 'houses/destroy'
  # get 'attractions/index'
  # get 'attractions/create'
  # get 'attractions/new'
  # get 'attractions/edit'
  # get 'attractions/show'
  # get 'attractions/update'
  # get 'attractions/destroy'
  get 'sessions/new'
  get 'welcome/home'
  # get 'users/new'

  root 'welcome#home'

  resources :users
  resources :houses

  resources :users, only: [:show, :index] do
    resources :reviews, only: [:show, :index]
  end

  resources :houses, only: [:show, :index] do
    resources :reviews, only: [:show, :index, :new, :create]
  end

  resources :users
  resources :houses
  resources :reviews, only: [:show]
  resources :stays, only: [:create]


  get '/signup', to: "users#new"
  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  post '/users/:id', to: "users#update"
  get '/auth/facebook/callback' => 'sessions#create'

end
