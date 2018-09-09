require 'api_constraints'

Rails.application.routes.draw do
   

 
  devise_for :users, controllers: { registrations: "registrations" }
  post '/api/auth_user' => 'authentication#authenticate_user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	devise_for :users do 
         resources :accounts, only: [:index, :show]
         resources :transactions
      end
      resources :picks do
        resources :media
        resources :links do
          resources :clicks
        end
      end
      resources :brands
      resources :shops do
        resources :deliveries do
          resources :tariffs
        end
        resources :feeds
        resources :products do 
        end
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
      resources :products do
        collection do
          get 'gift_products', to: 'products#gift_products'
        end
      end
      resources :categories
      resources :tags
      resources :hashtags
      resources :countries
      resources :country_shops
      resources :currencies
      resources :user_campaigns
      resources :relationships
      resources :employments
      resources :orders
    	put '/users/:id', to: 'registrations#update'
      get 'users/:id/feed' => 'users#feed'
      get '/users/:username' => 'users#show', :constrain => { :username => /[a-zA-Z-]+/ }
    end
  end

end
