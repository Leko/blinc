Rails.application.routes.draw do
  root 'home#index'

  get 'welcome/index'
  get 'welcome/term'
  get 'welcome/privacy'

  get 'home/index'

  get '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout
end
