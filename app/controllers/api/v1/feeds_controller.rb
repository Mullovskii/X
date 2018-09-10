module Api
  module V1

    class FeedsController < ApplicationController
      before_action :set_feed, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /feeds
      def index
        @feeds = Feed.all
        render json: @feeds
      end

      # GET /feeds/1
      def show
        render json: @feed
      end

      # POST /feeds
      def create
        @feed = Feed.new(feed_params)
        if current_user.employed_in(@feed.shop)
          if @feed.save
            if reward = @feed.shop.reward 
              if reward.country_id == @feed.country_id && reward.available_products == "all_country_products" && reward.product_reward == true
                @feed.update(gift_mode: true)
              end 
            end
            render json: @feed, status: :created, meta: default_meta, include: [params[:include]]
          else
            render json: @feed.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /feeds/1
      def update
        if current_user.employed_in(@feed.shop)
          if @feed.update(feed_params)
            if @feed.gift_mode_changed? || @feed.gift_mode == true
              @feed.products.each do |product|
                product.update(gift_mode: true)
              end
            elsif @feed.gift_mode_changed? || @feed.gift_mode == false
               @feed.products.each do |product|
                product.update(gift_mode: false)
              end
            end
            render json: @feed
          else
            render json: @feed.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /feeds/1
      def destroy
        if current_user.employed_in(@feed.shop)
          @feed.destroy
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_feed
          @feed = Feed.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def feed_params
          params.require(:feed).permit(:mode, :kind, :delivery_id, :shop_id, :format, :country_id, :currency_id, :name, :url, :author_id, :author_type, :gift_mode, :sample_mode, :sample_threshold)
        end
    end
  end
end