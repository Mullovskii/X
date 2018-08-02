module Api
  module V1
    class BrandsController < ApplicationController
      before_action :set_brand, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]


      # GET /brands
      def index
        @brands = Brand.all
        render json: @brands
      end

      # GET /brands/1
      def show
        render json: @brand
      end

      # POST /brands
      def create
        # if current_user.god?
        @brand = Brand.new(brand_params)
        if @brand.save
          render json: @brand, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @brand.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /brands/1
      def update
        if @brand.update(brand_params)
          render json: @brand
        else
          render json: @brand.errors, status: :unprocessable_entity
        end
      end

      # DELETE /brands/1
      # def destroy
      #   @brand.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_brand
          @brand = Brand.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def brand_params
          params.require(:brand).permit(:name, :mana, :main_category_id, :description, :avatar, :background, :main_country_id, :status)
        end
    end
  end
end 

