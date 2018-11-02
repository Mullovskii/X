module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_like, only: [:destroy]
      before_action :authenticate_request!

      # GET /likes
      def index
        @likes = current_user.likes
        render json: @likes, meta: default_meta, include: [params[:include]]
      end


      # POST /likes
      def create
        @like = current_user.likes.build(like_params.merge({liker_id: current_user.id, liker_type: current_user.class.to_s }))
        if @like.save
          render json: @like, status: :created
        else
          render json: @like.errors, status: :unprocessable_entity
        end
      end


      # DELETE /likes/1
      def destroy
        if current_user == @like.liker
          @like.destroy  
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_like
          @like = Like.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def like_params
          params.require(:like).permit(:liker_id, :liker_type, :liked_id, :liked_type)
        end
    end
  end
end
