class Pick < ApplicationRecord
	belongs_to :author, polymorphic: true
	has_many :media, as: :mediable, dependent: :destroy
	has_many :links, as: :linking, dependent: :destroy
	has_many :brands, through: :links, :source => :linked,
    :source_type => 'Brand'
    has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
    has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
	has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'
end
