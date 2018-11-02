class Reward < ApplicationRecord
  belongs_to :shop
  belongs_to :country
  belongs_to :currency, optional: true


  # has_many :gift_products

  enum available_products: [:all_country_products, :selected_feeds, :selected_products]
  enum delivery_mode: [:delivery, :voucher]
  enum fullfilment_mode: [:manually, :api]
  enum voucher_use: [:online, :offline]

  after_create :activate_gifts
  after_update :change_point_prices

  def gift_products
    self.shop.products.where(gift_mode: true)
  end

    def activate_gifts
    	if self.available_products == "all_country_products"
    		self.shop.feeds.where(country_id: self.country_id).each do |feed|
    			feed.update(gift_mode: true)
    		end
    	end
    end

    def change_point_prices
      if self.saved_change_to_point_to_usd?
        self.shop.products.where(gift_mode: true).each do |product|
          if self.product_reward == true
            if self.currency == product.feed.currency
              product.point_price = ((product.price / self.point_to_lcy)*100).round / 100.0
            else
              product.point_price = ((product.price / product.feed.currency.usd_rate / self.point_to_usd)*100).round / 100.0
            end 
          end
          product.save
        end
      end
    end

end
