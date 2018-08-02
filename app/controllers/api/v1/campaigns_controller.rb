module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /campaigns
      def index
        @campaigns = Campaign.all

        render json: @campaigns
      end

      # GET /campaigns/1
      def show
        render json: @campaign
      end

      # POST /campaigns
      def create
        @campaign = current_user.launched_campaigns.build(campaign_params.merge({ author_id: current_user.id, author_type: current_user.class.to_s }))
        if current_user.employed_in(@campaign.shop)
          if @campaign.save
            render json: @campaign, status: :created
          else
            render json: @campaign.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /campaigns/1
      def update
        if current_user.employed_in(@campaign.shop)
          if @campaign.update(campaign_params)
            render json: @campaign
          else
            render json: @campaign.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /campaigns/1
      def destroy
        if current_user.employed_in(@campaign.shop)
          @campaign.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_campaign
          @campaign = Campaign.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def campaign_params
          params.require(:campaign).permit(:shop_id, :name, :kind, :mode, :status, :bid_per_action, :currency_id, :actions_per_gift, :gift_id, :followers_threshold, :actions_per_gift)
        end
    end
  end
end