module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

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
        @campaign = Campaign.new(campaign_params)

        if @campaign.save
          render json: @campaign, status: :created
        else
          render json: @campaign.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /campaigns/1
      def update
        if @campaign.update(campaign_params)
          render json: @campaign
        else
          render json: @campaign.errors, status: :unprocessable_entity
        end
      end

      # DELETE /campaigns/1
      def destroy
        @campaign.destroy
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