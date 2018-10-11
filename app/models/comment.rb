class Comment < ApplicationRecord
	belongs_to :author, polymorphic: true
	belongs_to :commented, polymorphic: true
end
