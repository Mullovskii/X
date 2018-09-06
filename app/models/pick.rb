class Pick < ApplicationRecord
	belongs_to :author, polymorphic: true
	has_many :media, as: :mediable, dependent: :destroy
	has_many :links, as: :linking, dependent: :destroy
	has_many :brands, through: :links, :source => :linked,
    :source_type => 'Brand'
    has_many :products, through: :links, :source => :linked,
    :source_type => 'Product'
    has_many :campaigns, through: :links, :source => :linked,
    :source_type => 'Campaign'
    has_many :tags, as: :tagged, dependent: :destroy
	has_many :categories, through: :tags, :source => :tagger,
    :source_type => 'Category'
	has_many :hashtags, through: :tags, :source => :tagger,
    :source_type => 'Hashtag'
    has_many :clicks
    has_many :external_links

    enum status: [:edited, :published, :moderated]

    after_update :main_image_updater

    default_scope { order("created_at DESC") }

    def external_links
        self.links.where(kind: "external_link")
    end

    def main_image_updater
    	if self.status == "published" && self.media.first
    		self.main_image = self.media.first.url
    	end
    end

    # def check_user_campaigns
    # 	if self.products.take || self.brands.take
    		
    # 	end
    # end

end
