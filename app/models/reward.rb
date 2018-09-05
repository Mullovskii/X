class Reward < ApplicationRecord
  belongs_to :shop
  belongs_to :country
  belongs_to :currency

  enum available_products: [:all_country_products, :selected_feeds, :selected_products]
  enum delivery_mode: [:delivery, :voucher]
  enum fullfilment_mode: [:manually, :api]
  enum voucher_use: [:online, :offline]

   after_create :activate_gifts

    def activate_gifts
    	if self.available_products == "all_country_products"
    		self.shop.feeds.where(country_id: self.country_id).each do |feed|
    			feed.update(gift_mode: true)
    		end
    	end
    end

end
