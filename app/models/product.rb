class Product < ApplicationRecord
	belongs_to :shop
	belongs_to :feed
	belongs_to :brand

	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
end
