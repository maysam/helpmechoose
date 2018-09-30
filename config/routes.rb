Rails.application.routes.draw do
  get 'user/show'
  get 'user/index'
  resource 'user'
  delete 'sessions/destroy'
  get 'sessions/new'
  post 'sessions/create'
  root 'application#index'

  get 'login', to: 'logins#new'
  get 'login/create', to: 'logins#create', as: :create_login
end
