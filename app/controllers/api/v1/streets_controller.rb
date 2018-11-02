module Api
  module V1
    class StreetsController < ApplicationController
      before_action :set_street, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]
      
      # # GET /streets
      # def index
      #   @streets = Street.all

      #   render json: @streets
      # end

      # # GET /streets/1
      # def show
      #   render json: @street
      # end

      # POST /streets
      def create
        @street = Street.new(street_params)

        if @street.save
          render json: @street, status: :created
        else
          render json: @street.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /streets/1
      # def update
      #   if @street.update(street_params)
      #     render json: @street
      #   else
      #     render json: @street.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /streets/1
      def destroy
        @street.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_street
          @street = Street.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def street_params
          params.require(:street).permit(:city_id, :name)
        end
    end
   end
end

