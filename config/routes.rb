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
        resources :feeds do
          member do
            post :upload
            delete :remove_file
          end
        end
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
      
      
      resources :products do
        collection do
          get 'gift_products', to: 'products#gift_products'
        end
      end
      resources :showrooms do
        resources :product_showrooms
      end
      resources :sample_requests
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
    resources :cities
      resources :countries do
        member do
            get 'gifts', to: 'countries#gifts'
            get 'products', to: 'countries#products'
            get 'shops', to: 'countries#shops'
            get 'samples', to: 'countries#samples'
          end
      end
      resources :streets
      resources :swaps
      resources :addresses

    	put '/users/:id', to: 'registrations#update'
      get 'users/:id/accounts' => 'users#accounts'
      get 'users/:id/showroom' => 'users#showroom'
      get 'users/:id/feed' => 'users#feed'
      get '/users/:username' => 'users#show', :constrain => { :username => /[a-zA-Z-]+/ }
    end
  end

end
