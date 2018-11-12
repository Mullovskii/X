module Api
  module V1
    class MediaController < ApplicationController
      before_action :set_medium, only: [:show, :update, :destroy, :remove_url]
      before_action :authenticate_request!, only: [:create, :destroy]
      # skip_before_action :check_header, only: :create, :remove_url
      
      # GET /media/1
      def show
        render json: @medium, meta: default_meta, include: [params[:include]]
      end

      # POST /media
      def create
          # @medium = Medium.new(medium_params)
          @medium = Medium.new(params.permit(:mediable_id, :mediable_type, :url, :kind))
          if current_user == @medium.mediable.author 
            if @medium.save
              render json: @medium, status: :created, meta: default_meta, include: [params[:include]]
            else
              render json: @medium.errors, status: :unprocessable_entity
            end
          else
            render json: {errors: ['Invalid author']}, status: :unauthorized
          end
      end

      def remove_url
        @medium.remove_url!
        if @medium.save
          render json: @medium, meta: default_meta
        else
          render_error(@medium, 401)
        end
      end

      # PATCH/PUT /media/1
      # def update
      #   if @medium.update(medium_params)
      #     render json: @medium
      #   else
      #     render json: @medium.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /media/1
      def destroy
        if current_user == @medium.mediable.author 
          @medium.destroy
        else
          render json: {errors: ['Invalid author']}, status: :unauthorized
        end

      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_medium
          @medium = Medium.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def medium_params
          params.require(:medium).permit(:mediable_id, :mediable_type, :url, :kind)
        end
    end
  end
end