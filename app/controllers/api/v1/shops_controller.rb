module Api
  module V1
    class ShopsController < ApplicationController
      before_action :set_shop, only: [:show, :update, :destroy, :categories]
      before_action :authenticate_request!, only: [:update, :create]

      # GET /shops
      def index
        @shops = Shop.all
        render json: @shops
      end

      # GET /shops/1
      def show
        render json: @shop, meta: default_meta, include: [params[:include]]
      end

      # POST /shops
      def create
        @shop = current_user.shops.build(shop_params.merge({owner_id: current_user.id, owner_type: current_user.class.to_s }))
        if @shop.save
          render json: @shop, status: :created, meta: default_meta, include: [params[:include]]
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /shops/1
      def update
        if current_user.employed_in(@shop) 
          if @shop.update(shop_params)
            render json: @shop
          else
            render json: @shop.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized shop admin']}, status: :unauthorized
        end
      end

      def categories
        if params[:category].present?
          main_category = Category.find_by_id(params[:category])
          products = @shop.products.where(main_category_id: main_category.id)
          ids = products.map{ |p| p.id}
          # puts "hahahaa"
          # puts ids
          if params[:product].present?
            query = PgSearch.multisearch(params[:product]).where(:searchable_type => "Product")
            render json: query
          else
            render json: products.page(params[:page]).per(50).where(id: ids)  
          end
        else
          render json: @shop.categories
        end
      end


      # DELETE /shops/1
      # def destroy
      #   @shop.destroy
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shop
          @shop = Shop.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shop_params
          params.require(:shop).permit(:name, :brand_id, :accepted_rules, :customer_email, :order_email, :description, :legal_name, :website, :kind, :avatar, :background, :country_id, :mana, :user_id, :registration_number, :phone, :integration_type, :brand_name)
        end
    end
  end
end
