class Tariff < ApplicationRecord
  belongs_to :delivery
  enum mode: [:active, :off]
  enum kind: [:fixed, :price_dependant, :weight_dependant]
end
