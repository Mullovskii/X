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
            campaigns = []
            Campaign.all.where(kind: :link_referral).each do |campaign|
              #нужна еще валидация, что @link.external_link начинается с campaign.link_
              if @link.external_link.match?(campaign.link_1) 
                Link.create(linking_id: @link.linking_id, linking_type: @link.linking_type, linked_id: campaign.id, linking_type: "Campaign", kind: :campaign_link)
              elsif @link.external_link.match?(campaign.link_2)

              elsif @link.external_link.match?(campaign.link_3)

              elsif @link.external_link.match?(campaign.link_4)

              elsif @link.external_link.match?(campaign.link_5)
                
              end
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
          params.require(:link).permit(:linking_id, :linking_type, :linked_id, :linked_type, :kind, :external_link)
        end
    end
  end
end
