class Brand < ApplicationRecord
	enum status: [ :unactivated, :activated]
	has_many :links, as: :linked, dependent: :destroy
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_one :shop, as: :owner
end
