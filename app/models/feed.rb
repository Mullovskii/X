class Feed < ApplicationRecord
	belongs_to :shop
	belongs_to :country
	belongs_to :delivery
	belongs_to :currency
	has_many :products, dependent: :destroy
	has_many :gifts, dependent: :destroy
	has_many :feed_campaigns
	has_many :campaigns, through: :feed_campaigns
	enum mode: [:file, :mannual]
	enum format: [:xlsx, :csv, :txt]
	enum kind: [:product_feed, :gift_feed]

	after_update :products_gift_mode

	def products_gift_mode
		if self.saved_change_to_gift_mode?
			if self.gift_mode == true
				self.products.each do |product|
					product.gift_mode = true
					if self.shop.reward && self.shop.reward.product_reward == true
						if self.shop.reward.currency_id == self.currency_id
							product.point_price = (product.price / self.shop.reward.point_to_lcy*100).round / 100.0
						else
							product.point_price = (product.price / self.currency.usd_rate / self.shop.reward.point_to_usd*100).round / 100.0
						end	
					end
					product.save
				end
			else
				self.products.each do |product|
					product.gift_mode = false
					product.save
				end
			end
		end
	end



end

