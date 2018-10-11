class Tag < ApplicationRecord
	belongs_to :tagger, polymorphic: true #category or hashtag or brand
	belongs_to :tagged, polymorphic: true #pick, product, shop etc

	enum kind: [:category, :hashtag, :interest]
	validates :tagged_id, uniqueness: { scope: [:tagger_id, :tagger_type, :tagged_type] }

end
