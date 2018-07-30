class Product < ApplicationRecord
	belongs_to :shop
	belongs_to :feed
	belongs_to :brand

end
