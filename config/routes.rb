Rails.application.routes.draw do
  get 'user/show'
  get 'user/index'
  resources :users
  resources :tweets
  # delete 'sessions/destroy'
  # get 'sessions/new'
  # post 'sessions/new'
  # post 'sessions/create'
  resources :sessions
  root 'application#index'

  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login
  post 'users/auth'
  post 'users/signout'
end
