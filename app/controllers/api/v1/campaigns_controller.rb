module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :set_campaign, only: [:show, :update, :destroy, :generate_gifts, :campaign_products]
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

      def campaign_products
        @products = []
        if @campaign.campaign_products == "all_country_products" || @campaign.campaign_products == "selected_feeds" 
          @campaign.feeds.each do |feed|
            @products << feed.products
          end
        else
          @products << @campaign.shop.products.where(campaign_label: @campaign.label_1)
        end
        
        render json: @products, adapter: nil

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

      def generate_gifts
        if current_user.employed_in(@campaign.shop)
          @campaign.shop.feeds.where(country_id)
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
          params.require(:campaign).permit(:shop_id, :status, :name, :country_id, :kind, :link_referral, :link_1, :link_2, :link_3, :link_4, :link_5, :points_per_referral, :product_tagging, :points_per_tag, :campaign_products, :label_1, :label_2, :label_3)
        end
    end
  end
end