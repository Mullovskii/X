module Api
  module V1
    class ProductShowroomsController < ApplicationController
      before_action :set_product_showroom, only: [:destroy]
      before_action :authenticate_request!, only: [:destroy]

      # GET /product_showrooms
      # def index
      #   @product_showrooms = ProductShowroom.all

      #   render json: @product_showrooms
      # end

      # GET /product_showrooms/1
      # def show
      #   render json: @product_showroom
      # end

      # POST /product_showrooms
      # def create
      #   @product_showroom = ProductShowroom.new(product_showroom_params)

      #   if @product_showroom.save
      #     render json: @product_showroom, status: :created, location: @product_showroom
      #   else
      #     render json: @product_showroom.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /product_showrooms/1
      # def update
      #   if @product_showroom.update(product_showroom_params)
      #     render json: @product_showroom
      #   else
      #     render json: @product_showroom.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /product_showrooms/1
      def destroy
        if current_user.id == @product_showroom.showroom.owner_id
          @product_showroom.destroy
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_product_showroom
          @product_showroom = ProductShowroom.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def product_showroom_params
          params.require(:product_showroom).permit(:product_id, :showroom_id, :status)
        end
    end
  end
end
