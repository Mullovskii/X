module Api
  module V1
    class ShopsController < ApplicationController
      before_action :set_shop, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /shops
      def index
        @shops = Shop.all

        render json: @shops
      end

      # GET /shops/1
      def show
        render json: @shop
      end

      # POST /shops
      def create
        @shop = Shop.new(shop_params)

        if @shop.save
          render json: @shop, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /shops/1
      def update
        if @shop.update(shop_params)
          render json: @shop
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end

      # DELETE /shops/1
      def destroy
        @shop.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shop
          @shop = Shop.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shop_params
          params.require(:shop).permit(:name, :legal_name, :website, :business_type, :status, :avatar, :background, :main_category_id, :main_country_id, :mana, :user_id, :registration_number, :phone, :integration_type, :payment_rules, :owner_id, :owner_type)
        end
    end
  end
end
