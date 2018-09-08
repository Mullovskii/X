class RewardSerializer < ActiveModel::Serializer
  attributes :id, :product_reward, :point_to_usd, :point_to_lcy, :fullfilment_mode, :available_products, :delivery_mode, :gift_delivery_id, :surf_voucher_generation, :voucher_use, :voucher_instruction, :bonus_exchange, :point_to_bonus, :bonus_min_time, :bonus_max_time, :gift_min_time, :gift_max_time, :no_card_instruction, :other_instruction
  has_one :shop
  has_one :country
  has_one :currency
  has_many :gift_products
end
