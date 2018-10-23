module Api
  module V1
    class TariffsController < ApplicationController
      before_action :set_tariff, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /tariffs
      def index
        @tariffs = Tariff.all
        render json: @tariffs
      end

      # GET /tariffs/1
      def show
        render json: @tariff
      end

      # POST /tariffs
      def create
        @tariff = Tariff.new(tariff_params)
        unless @tariff.currency == Currency.where(name: ["KRW", 'JPY', 'HUF', 'ISK']).take
            @tariff.price_in_cents = @tariff.price_in_cents.to_f*100
        end
        if current_user.employed_in(@tariff.delivery.shop)
          if @tariff.save
            render json: @tariff, status: :created
          else
            render json: @tariff.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /tariffs/1
      def update
        if current_user.employed_in(@tariff.delivery.shop)
          if @tariff.update(tariff_params)
            render json: @tariff
          else
            render json: @tariff.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /tariffs/1
      def destroy
        if current_user.employed_in(@tariff.delivery.shop)
          @tariff.destroy
         else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_tariff
          @tariff = Tariff.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def tariff_params
          params.require(:tariff).permit(:name, :kind, :delivery_id, :mode, :product_price_from, :product_price_to, :weight_from, :weight_to, :price_in_cents)
        end
    end
  end
end
