module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: [:show, :update]
      before_action :authenticate_request!, only: [:show, :update]
     
      # GET /orders
      def index
        @orders = current_user.orders
        render json: @orders
      end

      # GET /orders/1
      def show
        if @order.user == current_user || current_user.employed_in(@order.shop) 
          render json: @order
        end
      end

      # POST /orders
      # def create
      #   @order = Order.new(order_params)

      #   if @order.save
      #     render json: @order, status: :created, location: @order
      #   else
      #     render json: @order.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /orders/1
      def update
        if @order.user == current_user || current_user.employed_in(@order.shop) 
          if @order.update(order_params)
            render json: @order
          else
            render json: @order.errors, status: :unprocessable_entity
          end
        else
        end
      end

      # DELETE /orders/1
      # def destroy
      #   @order.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_order
          @order = Order.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def order_params
          params.require(:order).permit(:ordered_id, :ordered_type, :user_id, :status, :kind, :value)
        end
    end
  end
end

