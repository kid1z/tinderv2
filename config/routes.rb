Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}


  mount ActionCable.server => '/cable'

  root 'home#index'

  # session 
  # resources :session, path: 'login',  only: [:new, :create]
  # delete '/signout', to: 'session#destroy'
  
  # app
  resources :app, path: 'app', only: [:new]
  post '/app/:id', to: 'app#create'
  
  # filter feature
  get '/filter', to: 'app#filter', as: 'filter'
  post '/filter', to: 'app#filter_by_condition'

  # user
  # resources :user, only: [:new, :create]
  # delete '/remove', to: 'user#destroy'

  # edit feature
  # put '/edit', to: 'user#update'
  # get '/edit', to: 'user#edit_profile'
  # get '/password', to: 'user#change_password_template'
  # change password feature
  # patch '/password', to: 'user#change_password'

  
  get '/message', to: 'user#message'

  get '/match', to: 'user#match'
  get '/message/:id',to: 'user#chat_room', as: 'chat_room'
  post '/message/:id', to: 'messages#create'
  


end
