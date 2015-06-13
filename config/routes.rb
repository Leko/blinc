Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  # Sessions
  get '/logout' => 'sessions#destroy', :as => :logout

  # Omniauth
  get '/auth/:provider/callback', :to => 'sessions#callback'
  post '/auth/:provider/callback', :to => 'sessions#callback'
end
