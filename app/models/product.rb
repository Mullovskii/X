class Product < ApplicationRecord
	belongs_to :shop
	belongs_to :feed
	belongs_to :brand

	has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'

    has_many :links, as: :linked
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_many :campaigns, through: :links, :source => :linking,
    :source_type => 'Campaign'
    belongs_to :campaign, optional: true
    has_many :clicks
    
end
