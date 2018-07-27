class Brand < ApplicationRecord
	enum status: [ :unactivated, :activated]
	has_many :links, as: :linked, dependent: :destroy
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_one :shop, as: :owner
    has_one :showroom, as: :owner
    after_create :generate_showroom

 	def generate_showroom
  		Showroom.create(owner_id: self.id, owner_type: self.class.to_s)
  	end
end
