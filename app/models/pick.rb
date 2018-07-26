class Pick < ApplicationRecord
	belongs_to :author, polymorphic: true
	has_many :media, as: :mediable, dependent: :destroy
	has_many :links, as: :linking, dependent: :destroy
	has_many :brands, through: :links, :source => :linked,
    :source_type => 'Brand'
end
