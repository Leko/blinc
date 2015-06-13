Rails.application.routes.draw do
  root 'home#index'

  get 'index', to: 'welcome#index'
  get 'term', to: 'welcome#term'
  get 'privacy', to: 'welcome#privacy'
  get 'help', to: 'welcome#help'

  get 'home/index'

  get '/auth/:provider/callback', :to => 'sessions#callback'
  get '/logout' => 'sessions#destroy', :as => :logout
end
