class Brand < ApplicationRecord
	enum status: [ :user_generated, :active_ugc, :active_shop]
	has_many :links, as: :linked, dependent: :destroy
	has_many :picks, through: :links, :source => :linking,
    :source_type => 'Pick'
    has_many :shops
    has_one :showroom, as: :owner
    has_many :products
    after_create :generate_showroom
    # belongs_to :category, optional: true

    has_many :picks, as: :author, dependent: :destroy
    

    has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'

    has_many :active_tags, as: :tagger, class_name: "Tag", dependent: :destroy
    has_many :shops, through: :active_tags, :source => :tagged,
    :source_type => 'Shop'

    validates :name, uniqueness: true
    default_scope { order("mana DESC") }

    include PgSearch
    multisearchable :against => [:name]

 	def generate_showroom
  		Showroom.create(owner_id: self.id, owner_type: self.class.to_s)
  	end

    def brand_picks
        picks = self.picks 
        Link.where(linked_id: self.id, linked_type: self.class.to_s).where.not(author_id: self.id, author_type: self.class.to_s).each do |link| 
            picks << link.linking 
        end
        picks.order("created_at DESC")
    end
end
