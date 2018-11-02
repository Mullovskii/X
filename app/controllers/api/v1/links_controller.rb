module Api
  module V1
    class LinksController < ApplicationController
      before_action :set_link, only: [:show, :update, :destroy] 
      before_action :authenticate_request!, only: [:create, :destroy]


      # POST /links
      def create
        @link = current_user.links.build(link_params.merge({ author_id: current_user.id, author_type: current_user.class.to_s }))
        if current_user == @link.linking.author 
          if @link.save
            # if @link.kind == "external_link"
            #   campaigns = []
            #   Campaign.all.where(link_referral: true).each do |campaign|
            #     #нужна еще валидация, что @link.external_link начинается с campaign.link_
            #     if @link.external_link.match?(campaign.link_1) || @link.external_link.match?(campaign.link_2) || @link.external_link.match?(campaign.link_3) || @link.external_link.match?(campaign.link_4) || @link.external_link.match?(campaign.link_5)
            #       campaigns << campaign
            #     end
            #   end
            #   response = { :link => @link, :campaigns => campaigns }
            #   render json: response
            
            # elsif @link.kind == "product_pick"
            #   campaigns = []
            #   if active_campaigns = @link.linked.feed.campaigns.where(status: "ongoing").take
            #     campaigns << active_campaigns
            #   elsif active_campaigns = @link.linked.shop.campaigns.where(label_1: @link.linked.campaign_label, status: "ongoing").take
            #     campaigns << active_campaigns
            #   end
              
            #   response = { :link => @link, :campaigns => campaigns }
            #   render json: response
    
            # else
            #   render json: @link, status: :created, meta: default_meta, include: [params[:include]]
            # end
            render json: @link, status: :created, meta: default_meta, include: [params[:include]]
          else
            render json: @link.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Invalid author']}, status: :unauthorized
        end
      end


      # DELETE /links/1
      def destroy
        if current_user == @link.linking.author 
          @link.destroy
        else
          render json: {errors: ['Invalid author']}, status: :unauthorized
        end

      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_link
          @link = Link.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def link_params
          params.require(:link).permit(:linking_id, :linking_type, :linked_id, :linked_type, :external_link, :medium_id, :x, :y, :status)
        end
    end
  end
end
