module Api
  module V1
    class EmploymentsController < ApplicationController
      before_action :set_employment, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /employments
      def index
        @employments = Employment.all

        render json: @employments
      end

      # GET /employments/1
      def show
        render json: @employment
      end

      # POST /employments
      def create
        @employment = Employment.new(employment_params)

        if @employment.save
          render json: @employment, status: :created
        else
          render json: @employment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /employments/1
      def update
        if @employment.update(employment_params)
          render json: @employment
        else
          render json: @employment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /employments/1
      def destroy
        @employment.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_employment
          @employment = Employment.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def employment_params
          params.require(:employment).permit(:user_id, :shop_id, :comment, :role, :status)
        end
    end
  end
end

