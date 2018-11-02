module Api
  module V1
    class DisputesController < ApplicationController
      before_action :set_dispute, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /disputes
      # def index
      #   @disputes = Dispute.all
      #   render json: @disputes
      # end

      # GET /disputes/1
      def show
        render json: @dispute
      end

      # POST /disputes
      def create
        @dispute = current_user.disputes.build(dispute_params.merge({ user_id: current_user.id }))
        @dispute.shop = @dispute.order.shop
        if current_user == @dispute.order.user
          unless @dispute.order.refund_expired? || @dispute.order.refund_invalid?
            if @dispute.save
              render json: @dispute, status: :created
            else
              render json: @dispute.errors, status: :unprocessable_entity
            end
          else
            render json: {errors: ['Unauthorized action']}, status: :unauthorized
          end
        else
          render json: {errors: ['Unauthorized user']}, status: :unauthorized
        end
      end

      # PATCH/PUT /disputes/1
      def update
        if @dispute.update(dispute_params)
          render json: @dispute
        else
          render json: @dispute.errors, status: :unprocessable_entity
        end
      end

      # DELETE /disputes/1
      # def destroy
      #   @dispute.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_dispute
          @dispute = Dispute.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def dispute_params
          params.require(:dispute).permit(:user_id, :shop_id, :order_id, :reason, :proof1, :proof2, :proof3, :proof4, :proof5, :parcel_proof1, :parcel_proof2, :parcel_proof3, :parcel_proof4, :parcel_proof5, :comment, :shop_agreement, :address_id, :status)
        end
    end
  end
end
