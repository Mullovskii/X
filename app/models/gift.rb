class Gift < ApplicationRecord
  belongs_to :shop
  belongs_to :feed, optional: true
  belongs_to :campaign, optional: true
  belongs_to :product, optional: true

  enum status: [:on, :off]
  
end
