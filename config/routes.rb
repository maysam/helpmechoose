Rails.application.routes.draw do
  resources :books
  get 'user/show'
  get 'user/index'
  resources :users
  resources :tweets
  resources :tags
  resources :words
  post 'words/:id', to: 'words#save_meanings'
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

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/', to: 'sync#index'
      get 'fetch', to: 'sync#fetch'
      post 'post', to: 'sync#post'
    end
  end
end
