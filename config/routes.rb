require 'api_constraints'

Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: "registrations" }
  post '/api/auth_user' => 'authentication#authenticate_user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	devise_for :users
      resources :picks
      resources :media
    	put '/users/:id', to: 'registrations#update'
    end
  end

end
