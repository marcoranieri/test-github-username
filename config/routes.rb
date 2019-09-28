Rails.application.routes.draw do

  get  'show',   to: 'pages#show'
  post 'create', to: 'pages#create'

  root to: 'pages#index'

end
