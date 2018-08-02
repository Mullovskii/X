require 'api_constraints'

Rails.application.routes.draw do
   
  devise_for :users, controllers: { registrations: "registrations" }
  post '/api/auth_user' => 'authentication#authenticate_user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	devise_for :users
      resources :picks
      resources :brands
      resources :media
      resources :links
      resources :shops
      resources :feeds
      resources :showrooms
      resources :products
      resources :categories
      resources :tags
      resources :hashtags
      resources :campaigns
      resources :countries
      resources :country_shops
      resources :deliveries
      resources :tariffs
      resources :currencies
      resources :feed_campaigns
      resources :clicks
      resources :user_campaigns
      resources :relationships
      resources :employments
      resources :gifts

    	put '/users/:id', to: 'registrations#update'
    end
  end

end
