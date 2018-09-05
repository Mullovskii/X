module Api
  module V1
    class RewardsController < ApplicationController
      before_action :set_reward, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /rewards
      def index
        @rewards = Reward.all

        render json: @rewards
      end

      # GET /rewards/1
      def show
        render json: @reward
      end

      # POST /rewards
      def create
        @reward = Reward.new(reward_params)
        if current_user.employed_in(@reward.shop)
          if @reward.save
            render json: @reward, status: :created
          else
            render json: @reward.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /rewards/1
      def update
        if current_user.employed_in(@reward.shop)
          if @reward.update(reward_params)
            render json: @reward
          else
            render json: @reward.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /rewards/1
      def destroy
        if current_user.employed_in(@reward.shop)
          @reward.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_reward
          @reward = Reward.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def reward_params
          params.require(:reward).permit(:shop_id, :country_id, :product_reward, :point_to_usd, :point_to_lcy, :currency_id, :fullfilment_mode, :available_products, :delivery_mode, :gift_delivery_id, :surf_voucher_generation, :voucher_use, :voucher_instruction, :bonus_exchange, :point_to_bonus, :bonus_min_time, :bonus_max_time, :gift_min_time, :gift_max_time, :no_card_instruction, :other_instruction)
        end
    end
  end
end