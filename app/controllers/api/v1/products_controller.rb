module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create, :destroy]

      # GET /products
      def index
        @products = Product.all

        render json: @products
      end

      def gift_products
        @products = Product.all.where(gift_mode: true)
        render json: @products
      end

      # GET /products/1
      def show
        render json: @product
      end

      # POST /products
      def create
        @product = Product.new(product_params)
        unless @product.currency == Currency.where(name: ["KRW", 'JPY', 'HUF', 'ISK']).take
            @product.price_in_cents = @product.price_in_cents.to_f*100
            @product.sale_price_in_cents = @product.sale_price_in_cents.to_f*100
        end
        if current_user.employed_in(@product.shop)
          if @product.save
            render json: @product, status: :created, meta: default_meta, include: [params[:include]]
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # PATCH/PUT /products/1
      def update
        if current_user.employed_in(@product.shop)
          if @product.update(product_params)
            render json: @product
          else
            render json: @product.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      # DELETE /products/1
      def destroy
        # (добавить) и если юзер работает на магазин, публикующий товар
        @product.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_product
          @product = Product.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def product_params
          params.require(:product).permit(:feed_id, :shop_id, :status, :item_id, :model_id, :brand_id, :custom_id, :brand_name, :title, :description, :link, :main_image_link, :availability, :availability_date, :cost_of_goods_sold_in_cents, :expiration_date, :price_in_cents, :sale_price_in_cents, :sale_price_effective_date, :unit_pricing_measure, :unit_pricing_base_measure, :installment, :loyalty_points, :main_category_id, :google_category_id, :product_type, :gtin, :mpn, :identifier_exists, :condition, :adult, :multipack, :is_bundle, :energy_efficiency_class, :min_energy_efficiency_class, :max_energy_efficiency_class, :age_group, :color, :gender, :material, :pattern, :size, :size_system, :item_group_id, :custom_label_0, :custom_label_1, :shipping, :shipping_label, :shipping_weight,:shipping_length, :shipping_width, :shipping_height, :max_handling_time, :min_handling_time, :tax, :tax_category, :production_country, :barcode, :image_link_0, :image_link_1, :image_link_2, :image_link_3, :image_link_4, :image_link_5, :image_link_6, :image_link_7, :image_link_8, :image_link_9, :venue, :gift_mode, :point_price, :country_id, :sample_mode, :sample_threshold, :currency_id)   
        end
    end
  end
end
