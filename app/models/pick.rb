class Pick < ApplicationRecord
	belongs_to :author, polymorphic: true
	has_many :media, as: :mediable, dependent: :destroy
end
