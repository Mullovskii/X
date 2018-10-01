class Tag < ApplicationRecord
	belongs_to :tagger, polymorphic: true #category or hashtag
	belongs_to :tagged, polymorphic: true #pick, product, shop etc

	enum kind: [:category, :hashtag, :interest]
end
