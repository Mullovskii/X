module Api
  module V1
    class ProductCouponsController < ApplicationController
      before_action :set_product_coupon, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /product_coupons
      def index
        @product_coupons = ProductCoupon.all

        render json: @product_coupons
      end

      # GET /product_coupons/1
      def show
        render json: @product_coupon
      end

      # POST /product_coupons
      def create
        @product_coupon = ProductCoupon.new(product_coupon_params)
        if current_user.employed_in(@product_coupon.product.shop)
          if @product_coupon.save
            render json: @product_coupon, status: :created
          else
            render json: @product_coupon.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /product_coupons/1
      def update
        if current_user.employed_in(@product_coupon.coupon.shop)
          if @product_coupon.update(product_coupon_params)
            render json: @product_coupon
          else
            render json: @product_coupon.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /product_coupons/1
      def destroy
        if current_user.employed_in(@product_coupon.coupon.shop)
          @product_coupon.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_product_coupon
          @product_coupon = ProductCoupon.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def product_coupon_params
          params.require(:product_coupon).permit(:product_id, :coupon_id)
        end
    end
  end
end
