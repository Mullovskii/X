module Api
  module V1
    class CouponsController < ApplicationController
      before_action :set_coupon, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:show, :update, :create, :destroy]

      # GET /coupons
      def index
        @coupons = Coupon.all

        render json: @coupons
      end

      # GET /coupons/1
      def show
        if current_user.coupons.where(id: @coupon.id).take
          response = { :coupon => @coupon, :secret => @coupon.secret }
          render json: response
        else
          render json: @coupon
        end
      end

      # POST /coupons
      def create
        @coupon = Coupon.new(coupon_params)
        if current_user.employed_in(@coupon.shop)
          if @coupon.save
            render json: @coupon, status: :created
          else
            render json: @coupon.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /coupons/1
      def update
        if current_user.employed_in(@coupon.shop)
          if @coupon.update(coupon_params)
            render json: @coupon
          else
            render json: @coupon.errors, status: :unprocessable_entity
          end
         else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /coupons/1
      def destroy
        if current_user.employed_in(@coupon.shop)
          @coupon.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_coupon
          @coupon = Coupon.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def coupon_params
          params.require(:coupon).permit(:shop_id, :country_id, :kind, :discount_mode, :discount, :discount_products, :additional_info, :coupon_use, :instruction, :background, :point_price, :secret, :number_of_coupons, :number, :status, :buyer_id, :purchased_at, :utilized_at, :currency_id)
        end
    end
  end
end
