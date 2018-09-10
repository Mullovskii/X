module Api
  module V1
    class SwapsController < ApplicationController
      before_action :set_swap, only: [:update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /swaps
      # def index
      #   @swaps = Swap.all

      #   render json: @swaps
      # end

      # GET /swaps/1
      # def show
      #   render json: @swap
      # end

      # POST /swaps
      def create
        @swap = current_user.swaps.build(swap_params.merge({user_id: current_user.id}))
        if @swap.shop.bonus_exchange == true && current_user.has_account?(@swap) && current_user.has_points?(@swap) 
          if @swap.save
            render json: @swap, status: :created
          else
            render json: @swap.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Order already exists']}, status: :unauthorized
        end
      end

      # PATCH/PUT /swaps/1
      def update
        if @swap.update(swap_params)
          render json: @swap
        else
          render json: @swap.errors, status: :unprocessable_entity
        end
      end

      # DELETE /swaps/1
      def destroy
        @swap.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_swap
          @swap = Swap.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def swap_params
          params.require(:swap).permit(:user_id, :amount, :bonuses, :shop_id, :status, :card_number, :account_id)
        end
    end
  end
end
