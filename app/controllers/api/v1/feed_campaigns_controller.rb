module Api
  module V1
    class FeedCampaignsController < ApplicationController
      before_action :set_feed_campaign, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /feed_campaigns
      def index
        @feed_campaigns = FeedCampaign.all

        render json: @feed_campaigns
      end

      # GET /feed_campaigns/1
      def show
        render json: @feed_campaign
      end

      # POST /feed_campaigns
      def create
        @feed_campaign = FeedCampaign.new(feed_campaign_params)
        if current_user.employed_in(@feed_campaign.feed.shop)
          if @feed_campaign.save
            render json: @feed_campaign, status: :created
          else
            render json: @feed_campaign.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /feed_campaigns/1
      # def update
      #   if @feed_campaign.update(feed_campaign_params)
      #     render json: @feed_campaign
      #   else
      #     render json: @feed_campaign.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /feed_campaigns/1
      def destroy
        if current_user.employed_in(@feed_campaign.feed.shop)
          @feed_campaign.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_feed_campaign
          @feed_campaign = FeedCampaign.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def feed_campaign_params
          params.require(:feed_campaign).permit(:feed_id, :campaign_id, :status)
        end
    end
  end
end 
