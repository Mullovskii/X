module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :set_invoice, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]
      # GET /invoices
      def index
        @invoices = Invoice.all
        render json: @invoices
      end

      # GET /invoices/1
      def show
        render json: @invoice
      end

      # POST /invoices
      def create
        @invoice = current_user.invoices.build(invoice_params.merge({user_id: current_user.id}))

        #логика конверсии валюты в валюту кампании
        if @invoice.shop && current_user.employed_in(@invoice.shop) || @invoice.user_id == current_user.id && @invoice.account.user_id == current_user.id && @invoice.valid_amount
          if @invoice.save
            render json: @invoice, status: :created
          else
            render json: @invoice.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      # PATCH/PUT /invoices/1
      def update
        if current_user #добавить только для админов
          if @invoice.update(invoice_params)
            render json: @invoice
          else
            render json: @invoice.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /invoices/1
      # def destroy
      #   @invoice.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_invoice
          @invoice = Invoice.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def invoice_params
          params.require(:invoice).permit(:shop_id, :status, :payment_method, :amount_in_cents, :vat_in_cents, :campaign_id, :card_number, :kind, :account_id)
        end
    end
  end
end
