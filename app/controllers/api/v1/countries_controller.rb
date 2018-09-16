module Api
  module V1
    class CountriesController < ApplicationController
      before_action :set_country, only: [:gifts, :show, :update, :destroy, :products, :shops, :samples]
      before_action :authenticate_request!, only: [:update, :create]


      # GET /countries
      def index
        @countries = Country.all

        render json: @countries
      end

      # GET /countries/1
      def show
        render json: @country
      end

      # POST /countries
      def create
        @country = Country.new(country_params)

        if @country.save
          render json: @country, status: :created
        else
          render json: @country.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /countries/1
      def update
        if @country.update(country_params)
          render json: @country
        else
          render json: @country.errors, status: :unprocessable_entity
        end
      end

      def gifts
        @gift_products = Product.all.where(country_id: @country.id, gift_mode: true)
        render json: @gift_products
      end

      def products
        @products = Product.all.where(country_id: @country.id)
        render json: @products
      end

      def samples
        @samples = Product.all.where(country_id: @country.id, sample_mode: true)
        render json: @samples
      end

      def shops
        @shops = []
        Shop.all.each do |shop|
          if shop.deliveries.where(country_id: @country.id).take
            @shops << shop
          end
        end
        render json: @shops
      end

      # DELETE /countries/1
      def destroy
        @country.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_country
          @country = Country.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def country_params
          params.require(:country).permit(:name, :status)
        end
    end
  end
end
