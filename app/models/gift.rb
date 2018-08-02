class Gift < ApplicationRecord
  belongs_to :shop
  belongs_to :campaign
  belongs_to :product, optional: true

  enum status: [:on, :off]
  
end
