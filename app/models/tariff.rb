class Tariff < ApplicationRecord
  belongs_to :delivery
  enum mode: [:active, :off]
  enum kind: [:fixed, :price_dependant, :weight_dependant]

  after_create :price_to_cents

  	def price_to_cents
        unless self.currency == Currency.where(name: ["KRW", 'JPY', 'HUF', 'ISK']).take
            self.price_in_cents = self.price_in_cents.to_f*100
            self.product_price_from = self.price_in_cents.to_f*100
            self.product_price_to = self.price_in_cents.to_f*100
        end
        self.save
    end

end
