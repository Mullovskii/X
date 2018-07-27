class Showroom < ApplicationRecord
	belongs_to :owner, polymorphic: true
end
