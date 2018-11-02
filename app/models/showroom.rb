class Showroom < ApplicationRecord
	belongs_to :owner, polymorphic: true
	has_many :product_showrooms
	has_many :products, through: :product_showrooms 
end
