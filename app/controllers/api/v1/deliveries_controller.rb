module Api
  module V1
    class DeliveriesController < ApplicationController
      before_action :set_delivery, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /deliveries
      def index
        @deliveries = Delivery.all
        render json: @deliveries
      end

      # GET /deliveries/1
      def show
        render json: @delivery
      end

      # POST /deliveries
      def create
        @delivery = Delivery.new(delivery_params)
        if current_user.employed_in(@delivery.shop)
          if @delivery.save
            render json: @delivery, status: :created
          else
            render json: @delivery.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /deliveries/1
      def update
        if current_user.employed_in(@delivery.shop)
          if @delivery.update(delivery_params)
            render json: @delivery
          else
            render json: @delivery.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /deliveries/1
      def destroy
        if current_user.employed_in(@delivery.shop)
          @delivery.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_delivery
          @delivery = Delivery.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def delivery_params
          params.require(:delivery).permit(:shop_id, :country_id, :mode, :weekends_delivery, :holidays_delivery, :pickup)
        end
    end
  end
end
