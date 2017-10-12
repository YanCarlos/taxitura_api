Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/auth', to: 'authentication#autenthicate_user'
  get '/logout', to: 'authentication#logout_user'

  namespace :api do
    namespace :v1 do
      post '/logout', to: 'users#logout'
      get '/me', to: 'users#me'
      resources :users
    end
  end
end
