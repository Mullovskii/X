module Api
  module V1
    class GiftsController < ApplicationController
      before_action :set_gift, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /gifts
      def index
        @gifts = Gift.all

        render json: @gifts
      end

      # GET /gifts/1
      def show
        render json: @gift
      end

      # POST /gifts
      def create
        @gift = Gift.new(gift_params)
        if @gift.save
          render json: @gift, status: :created
        else
          render json: @gift.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /gifts/1
      def update
        if @gift.update(gift_params)
          render json: @gift
        else
          render json: @gift.errors, status: :unprocessable_entity
        end
      end

      # DELETE /gifts/1
      def destroy
        @gift.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_gift
          @gift = Gift.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def gift_params
          params.require(:gift).permit(:shop_id, :feed_id, :virtual_good, :secret, :brand_id, :custom_id, :brand, :main_category_id, :product_type, :related_product_id, :campaign_id, :product_id, :title, :description, :main_image_link, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :status, :expiration_date, :number_of_units, :delivery_details, :number_of_gifts)
        end
    end

  end
end 

