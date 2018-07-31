class Campaign < ApplicationRecord

	enum kind: [:referral, :data_transfer, :purchase]
	enum mode: [:money, :physical_gifts, :virtual_gifts]
	enum status: [:fresh, :submitted, :declined, :ongoing, :stopped, :cancelled, :finished]

	belongs_to :shop

	has_many :links, as: :linking, dependent: :destroy
	has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
	
end

