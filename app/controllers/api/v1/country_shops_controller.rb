module Api
  module V1
    class CountryShopsController < ApplicationController
      before_action :set_country_shop, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /country_shops
      def index
        @country_shops = CountryShop.all
        render json: @country_shops
      end

      # GET /country_shops/1
      def show
        render json: @country_shop
      end

      # POST /country_shops
      def create
        @country_shop = CountryShop.new(country_shop_params)
        if current_user.employed_in(@country_shop.shop)
          if @country_shop.save
            render json: @country_shop, status: :created
          else
            render json: @country_shop.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /country_shops/1
      # def update
      #   if current_user.employed_in(@country_shop.shop)
      #     if @country_shop.update(country_shop_params)
      #       render json: @country_shop
      #     else
      #       render json: @country_shop.errors, status: :unprocessable_entity
      #     end
      #   else
      #     render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
      #   end
      # end

      # DELETE /country_shops/1
      def destroy
        if current_user.employed_in(@country_shop.shop)
          @country_shop.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_country_shop
          @country_shop = CountryShop.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def country_shop_params
          params.require(:country_shop).permit(:shop_id, :country_id, :mode)
        end
    end
  end
end
