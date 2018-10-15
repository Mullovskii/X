class Currency < ApplicationRecord
	belongs_to :country

	def to_usd_price(amount)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		amount/usd_rate
	end

	def to_local_price(usd_price)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		usd_price*usd_rate
	end
end
