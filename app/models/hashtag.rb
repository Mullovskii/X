class Hashtag < ApplicationRecord
	has_many :tags, as: :tagger, dependent: :destroy
	has_many :picks, through: :tags, :source => :tagged,
    :source_type => 'Pick'
    has_many :users, through: :tags, :source => :tagged,
    :source_type => 'User'
    has_many :brands, through: :tags, :source => :tagged,
    :source_type => 'Brand'
    has_many :shops, through: :tags, :source => :tagged,
    :source_type => 'Shop'

    include PgSearch
  	multisearchable :against => :name
  	paginates_per 10

end
