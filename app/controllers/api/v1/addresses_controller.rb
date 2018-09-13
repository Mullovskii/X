module Api
  module V1
    class AddressesController < ApplicationController
      before_action :set_address, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /addresses
      # def index
      #   @addresses = Address.all

      #   render json: @addresses
      # end

      # GET /addresses/1
      # def show
      #   render json: @address
      # end

      # POST /addresses
      def create
        @address = current_user.addresses.build(address_params.merge({owner_id: current_user.id, owner_type: current_user.class.to_s }))

        if @address.save
          render json: @address, status: :created
        else
          render json: @address.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /addresses/1
      def update
        if current_user.id == @address.owner_id
          if @address.update(address_params)
            render json: @address
          else
            render json: @address.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      # DELETE /addresses/1
      def destroy
        if current_user.id == @address.owner_id
          @address.destroy
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_address
          @address = Address.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def address_params
          params.require(:address).permit(:country_id, :city_id, :street_id, :owner_id, :owner_type, :building, :apartment, :postcode, :kind)
        end
    end
  end
end
