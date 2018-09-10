module Api
  module V1
    class ShowroomsController < ApplicationController
      before_action :set_showroom, only: [:show]
      # before_action :authenticate_request!, only: [:update, :create]

      # GET /showrooms
      def index
        @showrooms = Showroom.all

        render json: @showrooms
      end

      # GET /showrooms/1
      def show
        render json: @showroom.products, meta: default_meta, include: [params[:include]]
      end

      # POST /showrooms
      # def create
      #   @showroom = Showroom.new(showroom_params)

      #   if @showroom.save
      #     render json: @showroom, status: :created, meta: default_meta, include: [params[:include]]
      #   else
      #     render json: @showroom.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /showrooms/1
      # def update
      #   if @showroom.update(showroom_params)
      #     render json: @showroom, meta: default_meta, include: [params[:include]]
      #   else
      #     render json: @showroom.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /showrooms/1
      # def destroy
      #   @showroom.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_showroom
          @showroom = Showroom.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def showroom_params
          params.require(:showroom).permit(:owner_id, :owner_type, :description, :mana)
        end
    end
  end
end
