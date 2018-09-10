module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:index, :show]

      # GET /transactions
      def index
        @transactions = current_user.transactions.all
        render json: @transactions
      end

      # GET /transactions/1
      def show
        if @account.user == current_user || current_user.employed_in(@transaction.account.shop) 
          render json: @transaction
        end
      end

      # POST /transactions
      def create
        if current_user.has_account?(@transaction) && current_user.has_points?(@transaction)  
          if transaction.purchased.shop.integration_type == "manual"
            order = Order.create(ordered_id: self.purchased_id, ordered_type: self.purchased_type, amount: self.amount, shop_id: self.purchased.shop_id, user_id: current_user.id)
            if order.status == "success"
              @transaction = current_user.transactions.build(transaction_params.merge({user_id: current_user.id}))
              if @transaction.save
                render json: @transaction, status: :created
              else
                render json: @transaction.errors, status: :unprocessable_entity
              end
            else
              render json: {errors: ['Cancelled']}, status: :unauthorized  
            end
          else
            render json: {errors: ['API integration is unset']}, status: :unauthorized
          end
        else
          render json: {errors: ['Low funds']}, status: :unauthorized
        end
      end

      # PATCH/PUT /transactions/1
      # def update
      #   # прописать логику изменения только для админов
      #   if @transaction.update(transaction_params)
      #     render json: @transaction
      #   else
      #     render json: @transaction.errors, status: :unprocessable_entity
      #   end
      # end

      # DELETE /transactions/1
      # def destroy
      #   @transaction.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_transaction
          @transaction = Transaction.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def transaction_params
          params.require(:transaction).permit(:account_id, :purchased_id, :purchased_type, :amount, :status, :order_id, :swap_id)
        end
    end
  end
end

