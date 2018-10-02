class Category < ApplicationRecord
	belongs_to :parent_category, class_name: "Category", foreign_key: "parent_id", optional: true
	has_many :child_categories, class_name: "Category", foreign_key: "parent_id"
	has_many :tags, as: :tagger, dependent: :destroy
	has_many :products, through: :tags, :source => :tagged,
    :source_type => 'Product'
    has_many :shops, through: :tags, :source => :tagged,
    :source_type => 'Shop'
    has_many :hashtags, through: :tags, :source => :tagged,
    :source_type => 'Hashtag'

    # default_scope { order("mana DESC") }
end
