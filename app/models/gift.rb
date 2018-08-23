class Gift < ApplicationRecord
  belongs_to :shop
  belongs_to :feed, optional: true
  belongs_to :campaign, optional: true
  belongs_to :product, optional: true

  enum status: [:on, :off]
  enum delivery_option: [:user_pickup, :user_call, :brand_call, :automatic_delivery]

end
