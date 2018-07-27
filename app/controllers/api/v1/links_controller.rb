module Api
  module V1
    class LinksController < ApplicationController
      before_action :set_link, only: [:show, :update, :destroy] 
      before_action :authenticate_request!, only: [:create, :destroy]


      # POST /links
      def create
        @link = Link.new(link_params)

        if @link.save
          render json: @link, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @link.errors, status: :unprocessable_entity
        end
      end


      # DELETE /links/1
      def destroy
        @link.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_link
          @link = Link.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def link_params
          params.require(:link).permit(:linking_id, :linking_type, :linked_id, :linked_type)
        end
    end
  end
end