module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: [:show, :update]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /accounts
      def index
        @accounts = current_user.accounts
        render json: @accounts
      end

      # GET /accounts/1
      def show
        if @account.user == current_user || current_user.employed_in(@account.shop) 
          render json: @account
        end
      end

      # POST /accounts
      # def create
      #   @account = Account.new(account_params)

      #   if @account.save
      #     render json: @account, status: :created, location: @account
      #   else
      #     render json: @account.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /accounts/1
      def update
        if current_user.employed_in(@account.shop) || current_user.id == @account.user_id
          if @account.update(account_params)
            render json: @account
          else
            render json: @account.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      # DELETE /accounts/1
      # def destroy
      #   @account.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_account
          @account = Account.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def account_params
          params.require(:account).permit(:kind)
        end
    end
  end
end
