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
      resources :shops do
        resources :deliveries do
          resources :tariffs
        end
        resources :feeds
        resources :products
        resources :gifts
        resources :rewards
        resources :coupons do
          resources :product_coupons
        end
        resources :campaigns do
          resources :feed_campaigns  
          member do
            get 'campaign_products', to: 'campaigns#campaign_products'
          end        
        end
        # resources :feeds
      end
      
      resources :showrooms
      resources :products
      resources :categories
      resources :tags
      resources :hashtags
      
      resources :countries
      resources :country_shops
      
      
      resources :currencies
      
      resources :clicks
      resources :user_campaigns
      resources :relationships
      resources :employments
      
      
    	put '/users/:id', to: 'registrations#update'
      get 'users/:id/feed' => 'users#feed'
      get '/users/:username' => 'users#show', :constrain => { :username => /[a-zA-Z-]+/ }
    end
  end

end
