module Api
  module V1
    class ClicksController < ApplicationController
      before_action :set_click, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /clicks
      # def index
      #   @clicks = Click.all
      #   render json: @clicks
      # end

      # GET /clicks/1
      # def show
      #   render json: @click
      # end

      # POST /clicks
      def create
          @click = current_user.clicks.build(click_params.merge({ user_id: current_user.id }))
          if @click.valid && @click.not_self_made
            if @click.save
              render json: @click, status: :created
            else
              render json: @click.errors, status: :unprocessable_entity
            end
        else
            render json: {errors: ['Click exists. Dont fraud']}, status: :unauthorized
          end        
      end

      # PATCH/PUT /clicks/1
      def update
        unless @click.status == "on"
          if @click.update(click_params)
            @click.add_points
            render json: @click
          else
            render json: @click.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Click is already on. Dont fraud']}, status: :unauthorized
        end
      end

      # DELETE /clicks/1
      def destroy
        @click.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_click
          @click = Click.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def click_params
          params.require(:click).permit(:pick_id, :link_id, :status, :trigger_time)
        end
    end
   end
end 

