Rails.application.routes.draw do
  get 'user/show'
  get 'user/index'
  resource 'user'
  delete 'sessions/destroy'
  get 'sessions/new'
  post 'sessions/create'
  root 'application#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
