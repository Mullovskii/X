module Api
  module V1
    class UserCampaignsController < ApplicationController
      before_action :set_user_campaign, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /user_campaigns
      def index
        @user_campaigns = UserCampaign.all

        render json: @user_campaigns
      end

      # GET /user_campaigns/1
      def show
        render json: @user_campaign
      end

      # POST /user_campaigns
      def create
        @user_campaign = current_user.user_campaigns.build(user_campaign_params.merge({ user_id: current_user.id}))
        unless current_user.campaigns.where(id: @user_campaign.campaign.id)
          if current_user.true_picker?(@user_campaign)
            if @user_campaign.save
              render json: @user_campaign, status: :created
            else
              render json: @user_campaign.errors, status: :unprocessable_entity
            end
          else
            render json: {errors: ['Unauthorized to participate']}, status: :unauthorized
          end
        else
          render json: {errors: ['Already participating']}, status: :unauthorized
        end
      end

      # PATCH/PUT /user_campaigns/1
      def update
        if @user_campaign.update(user_campaign_params)
          render json: @user_campaign
        else
          render json: @user_campaign.errors, status: :unprocessable_entity
        end
      end

      # DELETE /user_campaigns/1
      def destroy
        @user_campaign.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user_campaign
          @user_campaign = UserCampaign.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def user_campaign_params
          params.require(:user_campaign).permit(:campaign_id, :status, :link_id, :gift_id)
        end
    end
  end
end
