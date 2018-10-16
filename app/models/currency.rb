class Currency < ApplicationRecord
	belongs_to :country

	after_create :money

	def money
		# require 'money'
		# # 10.00 USD
		# require 'eu_central_bank'
		# eu_bank = EuCentralBank.new
		# Money.default_bank = eu_bank
		# money1 = Money.new(10)
		# money1.bank # eu_bank
		# eu_bank.update_rates
		# eu_bank.exchange(100, "CAD", "USD")
		# money = Money.us_dollar(1).exchange_to("RUB")
		# money = Money.new(1000, "EUR").exchange_to("USD")
		puts money.bank
	end

	def to_usd_price(amount)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		amount/usd_rate
	end

	def to_local_price(usd_price)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		usd_price*usd_rate
	end
end
