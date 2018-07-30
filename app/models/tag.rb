class Tag < ApplicationRecord
	belongs_to :tagger, polymorphic: true
	belongs_to :tagged, polymorphic: true

	enum kind: [:category, :hashtag, :interest]
end
