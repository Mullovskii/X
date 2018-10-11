module Api
  module V1
    class WishesController < ApplicationController
      before_action :set_wish, only: [:show, :update, :destroy]
      before_action :authenticate_request!

      # GET /wishes
      def index
        @wishes = current_user.wishes.all
        render json: @wishes, meta: default_meta, include: [params[:include]]
      end


      # POST /wishes
      def create
        @wish = current_user.wishes.build(wish_params.merge({user_id: current_user.id}))

        if @wish.save
          render json: @wish, status: :created
        else
          render json: @wish.errors, status: :unprocessable_entity
        end
      end


      # DELETE /wishes/1
      def destroy
        if current_user == @wish.user
          @wish.destroy
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
        
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_wish
          @wish = Wish.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def wish_params
          params.require(:wish).permit(:user_id, :product_id)
        end
    end
  end
end
