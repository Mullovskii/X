class ProductShowroom < ApplicationRecord
  belongs_to :product
  belongs_to :showroom

  enum status: [:verified, :unverified]

end
