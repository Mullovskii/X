module Api
  module V1

    class FeedsController < ApplicationController
      before_action :set_feed, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

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

        if @feed.save
          render json: @feed, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @feed.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /feeds/1
      def update
        if @feed.update(feed_params)
          render json: @feed
        else
          render json: @feed.errors, status: :unprocessable_entity
        end
      end

      # DELETE /feeds/1
      def destroy
        @feed.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_feed
          @feed = Feed.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def feed_params
          params.require(:feed).permit(:mode, :shop_id, :format, :target_country_id, :content_language, :currency, :name, :input_type, :url, :author_id, :author_type)
        end
    end
  end
end