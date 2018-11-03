require 'api_constraints'

Rails.application.routes.draw do
   

 
 
  
  
  
  devise_for :users, controllers: { registrations: "registrations" }
  post '/api/auth_user' => 'authentication#authenticate_user'
  get '/api/user' => 'authentication#get_user'
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
      resources :brands do
        member do
          get :shops
        end
      end
      resources :invoices
      resources :shops do
        resources :deliveries do
          resources :tariffs
        end
        resources :feeds do
          member do
            post :upload
            delete :remove_file
            get :generate_products
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
        member do 
          get :categories
        end
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
      resources :hashtags do 
        member do 
          get "users", to: "hashtags#users"
          get "brands", to: "hashtags#brands"
        end
      end
      resources :countries
      resources :country_shops
      resources :currencies
      resources :user_campaigns
      resources :relationships
      resources :employments
      resources :orders do
        member do
          resources :shippings
          resources :disputes
        end
      end
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
      resources :accounts, only: [:update]
      resources :swaps
      resources :addresses
      resources :notifications
      resources :search, only: [:index]
      resources :wishes
      resources :comments
      resources :likes
      

    	patch '/users/:id', to: 'registrations#update'
      get 'users/:id/accounts' => 'users#accounts'
      get 'users/:id/showroom' => 'users#showroom'
      get 'users' => 'users#index'
      get 'current' => 'users#get_user'
      get 'users/:id/feed' => 'users#feed'
      get 'feed' => 'users#feed'
      get 'new_orders' => 'users#new_orders'
      get 'history' => 'users#history'
      get 'disputes' => 'users#disputes'
      get 'activities' => 'users#activities'
      get 'user_addresses' => 'users#user_addresses'
      get '/users/:username' => 'users#show', :constrain => { :username => /[a-zA-Z-]+/ }
    end
  end

end
