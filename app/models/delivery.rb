class Delivery < ApplicationRecord
  belongs_to :shop
  belongs_to :product, optional: true 
  belongs_to :country, optional: true
  belongs_to :currency
  has_many :tariffs

  enum mode: [:default, :specific]
  after_create :price_to_cents
  # validates :product_id, uniqueness: { scope: [:shop_id, :country_id] }

  	def price_to_cents
        unless self.currency == Currency.where(name: ["KRW", 'JPY', 'HUF', 'ISK']).take
            self.price_in_cents = self.price_in_cents.to_f*100
        end
        self.save
    end

    def price_to_usd
    	Money.new(self.price_in_cents, self.currency.name).exchange_to("USD")
    end

    def price_to_rub
    	Money.new(self.price_in_cents, self.currency.name).exchange_to("RUB")
    end

end
