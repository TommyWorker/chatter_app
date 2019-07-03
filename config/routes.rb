Rails.application.routes.draw do
  get 'posts/index'
  get 'talks/index'
  get '/' => "users#login_form"
  get 'login' => "users#login_form"
  get 'users/login' => "users#login_form"
  post "login"  => "users#login"
  post "/logout" => "users#logout"
  post 'users/:id/update' => "users#update"
  get 'users/:id/edit' => "users#edit"
  get '/signup' => "users#new"
  post 'users/create' => "users#create"
  get 'users/index' => "users#index"
  get 'users/:id' => "users#show"
  get 'users/:id/talkentry' => "users#talkentry"
  get 'talks/:talk_id/room' => "talks#room"
  get 'talks/index' => "talks#index"

  mount ActionCable.server => "/cable"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
