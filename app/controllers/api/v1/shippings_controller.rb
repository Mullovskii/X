module Api
  module V1
    class ShippingsController < ApplicationController
      before_action :set_shipping, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]
 

      # GET /shippings/1
      def show
        render json: @shipping
      end

      # POST /shippings
      def create
        @shipping = Shipping.new(shipping_params)
        unless @shipping.dispute_id.nil?
          @shipping.order = @shipping.dispute.order
          @shipping.kind = "refund_delivery"
        end
        @shipping.shop = @shipping.order.shop
        if current_user.employed_in(@shipping.shop) || current_user == @shipping.order.user
          if @shipping.save
            render json: @shipping, status: :created
          else
            render json: @shipping.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /shippings/1
      def update
        if current_user.employed_in(@shipping.shop) || current_user.surf_god?
          unless current_user.employed_in(@shipping.shop) && @shipping.saved_change_to_status? 
            if @shipping.update(shipping_params)
              render json: @shipping
            else
              render json: @shipping.errors, status: :unprocessable_entity
            end
          else
            render json: {errors: ['Unauthorized action']}, status: :unauthorized
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /shippings/1
      # def destroy
      #   @shipping.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shipping
          @shipping = Shipping.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shipping_params
          params.require(:shipping).permit(:order_id, :dispute_id, :provider, :tracking_number, :note, :shop_delivery_confirmation, :user_delivery_confirmation, :surf_delivery_confirmation)
        end
    end
  end
end
