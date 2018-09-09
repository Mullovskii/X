module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: [:show, :update]
      before_action :authenticate_request!, only: [:show, :update, :create]
     
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
      def create
        @order = current_user.orders.build(order_params.merge({user_id: current_user.id}))
        if current_user.has_account?(@order) && current_user.has_points?(@order)   
          if @order.save
            render json: @order, status: :created
          else
            render json: @order.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Low funds']}, status: :unauthorized
        end
      end

      # PATCH/PUT /orders/1
      def update
        if current_user.employed_in(@order.shop) 
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
          params.require(:order).permit(:ordered_id, :ordered_type, :shop_id, :user_id, :status, :kind, :amount, :confirmed_at, :cancelled_at  )
        end
    end
  end
end

