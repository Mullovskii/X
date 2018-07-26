class Link < ApplicationRecord
	belongs_to :linking, polymorphic: true
	belongs_to :linked, polymorphic: true
end
