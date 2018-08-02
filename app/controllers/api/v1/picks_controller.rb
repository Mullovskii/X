module Api
  module V1
    class PicksController < ApplicationController
      before_action :set_pick, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /picks
      def index
        @picks = Pick.all
        render json: @picks, meta: default_meta, include: [params[:include]]
      end

      # GET /picks/1
      def show
        render json: @pick, meta: default_meta, include: [params[:include]]
      end

      # POST /picks
      def create
        @pick = current_user.picks.build(pick_params.merge({ author_id: current_user.id, author_type: current_user.class.to_s }))
        if @pick.save
          render json: @pick, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @pick.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /picks/1
      def update
        if current_user == @pick.author # (добавить) и если юзер работает на бренд, публикующий пост
          if @pick.update(pick_params)
            render json: @pick
          else
            render json: @pick.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Invalid author']}, status: :unauthorized
        end
      end

      # DELETE /picks/1
      def destroy
        if current_user == @pick.author # (добавить) и если юзер работает на бренд, публикующий пост
          @pick.destroy
        else
          render json: {errors: ['Invalid author']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_pick
          @pick = Pick.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def pick_params
          params.require(:pick).permit(:body, :status)
          # ActiveModelSerializers::Deserialization.jsonapi_parse(params)
        end
    end

  end
end 
