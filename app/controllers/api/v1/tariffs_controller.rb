module Api
  module V1
    class TariffsController < ApplicationController
      before_action :set_tariff, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

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

        if @tariff.save
          render json: @tariff, status: :created
        else
          render json: @tariff.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tariffs/1
      def update
        if @tariff.update(tariff_params)
          render json: @tariff
        else
          render json: @tariff.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tariffs/1
      def destroy
        @tariff.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_tariff
          @tariff = Tariff.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def tariff_params
          params.require(:tariff).permit(:delivery_id, :mode, :price_from, :price_to, :weight_from, :weight_to, :days, :price, :currency_id)
        end
    end
  end
end
