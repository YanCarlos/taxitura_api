Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/auth', to: 'authentication#autenthicate_user'
  get '/logout', to: 'authentication#logout_user'
  get '/audited/:model/:id', to: 'audited#index'
  


  resources :inboxes
  resources :subscribers

  namespace :api do
    namespace :v1 do
      post '/logout', to: 'users#logout'
      get '/me', to: 'users#me'
      get '/password_update/:id', to:'users#show'
      put '/password_update/:id', to:'users#password_update'
      resources :users
      resources :drivers
      resources :packages
      resources :recharges
      resources :questions
      resources :recharge_homes
      resources :taxis
      resources :assign_taxis
      resources :services
    end
  end
  root :controller => 'home', :action => 'home'
end
