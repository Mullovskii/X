module Api
  module V1
    class SampleRequestsController < ApplicationController
      before_action :set_sample_request, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:show, :update, :create]

      # GET /sample_requests
      # def index
      #   @sample_requests = SampleRequest.all

      #   render json: @sample_requests
      # end

      # GET /sample_requests/1
      def show
        if current_user.employed_in(@sample_request.shop) || current_user.id == @sample_request.id
          render json: @sample_request
        end
      end

      # POST /sample_requests
      def create
        @sample_request = current_user.sample_requests.build(sample_request_params.merge({user_id: current_user.id}))
        @sample_request.shop = @sample_request.product.shop
        if @sample_request.product.sample_mode == true && @sample_request.user.followers.length >= @sample_request.product.sample_threshold
          if current_user.employed_in(@sample_request.shop) 
            @sample_request.kind = :shop_request
            @sample_request.shop_approval = true
            @sample_request.save
          elsif current_user.id == @sample_request.user_id
            @sample_request.kind = :user_request
            @sample_request.user_approval = true
          end
          if @sample_request.save
            render json: @sample_request, status: :created
          else
            render json: @sample_request.errors, status: :unprocessable_entity
          end
        else 
          render json: {errors: ['Product has no samples']}, status: :unauthorized
        end
      end

      # PATCH/PUT /sample_requests/1
      # def update
      #   if @sample_request.kind == "shop_request" && current_user.employed_in(@sample_request.shop)
      #     if @sample_request.saved_change_to_user_approval?
      #       render json: {errors: ['Unauthorized to change user status']}, status: :unauthorized
      #     else 
      #       if @sample_request.update(sample_request_params)
      #         render json: @sample_request
      #       else
      #         render json: @sample_request.errors, status: :unprocessable_entity
      #       end
      #     end
  
      #   elsif @sample_request.kind == "user_request" && current_user == @sample_request.user
      #     if @sample_request.saved_change_to_shop_approval?
      #       render json: {errors: ['Unauthorized to change shop status']}, status: :unauthorized
      #     else 
      #       if @sample_request.update(sample_request_params)
      #         render json: @sample_request
      #       else
      #         render json: @sample_request.errors, status: :unprocessable_entity
      #       end
      #     end
      #   else
      #     render json: @sample_request.errors, status: :unprocessable_entity
      #   end
      # end
            

      def update
          if @sample_request.update(sample_request_params)
            if @sample_request.saved_change_to_shop_approval? && current_user == @sample_request.user || @sample_request.saved_change_to_user_approval? && current_user.employed_in(@sample_request.shop)
              @sample_request.status = "fraud_detected"
              @sample_request.save
              render json: {errors: ['Unauthorized']}, status: :unauthorized
            else
              render json: @sample_request
            end
          else
            render json: @sample_request.errors, status: :unprocessable_entity
          end
      end



      # DELETE /sample_requests/1
      def destroy
        @sample_request.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_sample_request
          @sample_request = SampleRequest.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def sample_request_params
          params.require(:sample_request).permit(:user_id, :product_id, :shop_id, :user_approval, :shop_approval, :address_id, :comment)
        end
      end
   end
end

