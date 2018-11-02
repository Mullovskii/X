class Currency < ApplicationRecord

	# after_create :money

	# def money
	# # 	# require 'money'
	# # 	# # 10.00 USD
	# # 	# require 'eu_central_bank'
	# # 	# eu_bank = EuCentralBank.new
	# # 	# Money.default_bank = eu_bank
	# # 	# money = Money.default_bank.get_rate('EUR', 'JPY')

	# # 	money = Money.new(1000, "ZAR")
	# # 	# money1.bank # eu_bank
	# # 	# cache = "app/files/exchange_rates.xml"
	# # 	# eu_bank.save_rates(cache)
	# # 	# eu_bank.update_rates(cache)
	# # 	# eu_bank.exchange(100000, "RUB", "USD")
	# # 	# eu_bank = EuCentralBank.new
	# # 	# money = Money.default_bank.exchange(1000, "KRW", "USD")
	# # 	# currency = Money.new(1000, "RUB").currency
	# 	money = Money.new(1000, "EUR").exchange_to("USD")
	# 	puts money
	# end

	def to_usd_price(amount)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		amount/usd_rate
	end

	def to_local_price(usd_price)
		usd_rate = self.usd_rate #заменить на поставщика курсов
		usd_price*usd_rate
	end
end
