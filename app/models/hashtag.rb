class Hashtag < ApplicationRecord
	has_many :tags, as: :tagger, dependent: :destroy
	has_many :picks, through: :tags, :source => :tagged,
    :source_type => 'Pick'
end
