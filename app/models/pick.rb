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
    # before_update :whitelist
    after_update :find_hashtags, :add_brand_hashtag_and_category, :link_hashtags_to_categories

    default_scope { order("created_at DESC") }

    def external_links
        self.links.where(kind: "external_link")
    end

    def main_image_updater
    	if self.status == "published" && self.media.first
    		self.main_image = self.media.first.url
    	end
    end

    # def whitelist
    #     if self.saved_change_to_body?
    #         #вычистить скрипты
    #     end
    # end

    def find_hashtags
        if self.saved_change_to_body? && self.body
            # self.body.scan(/\B(\#[a-zA-Z]+\b)(?!;)/).each do |matching| 
            self.body.scan(/#\S+ */).each do |matching| #upgrade to save #x_y
                hashtag = Hashtag.find_or_create_by(name: matching[0].downcase.gsub!(/[^0-9A-Za-z]/, ''))
                Tag.create(tagger_id: hashtag.id, tagger_type: "Hashtag", tagged_id: self.id, tagged_type: "Pick")
            end
        end
  
    end

    def add_brand_hashtag_and_category
        if self.status == "published" && self.brands.take
            self.brands.each do |brand|
                hashtag = Hashtag.find_or_create_by(name: brand.name.downcase)
                Tag.create(tagger_id: hashtag.id, tagger_type: "Hashtag", tagged_id: self.id, tagged_type: "Pick")
                if brand.categories.take
                    brand.categories.each do |category|
                        Tag.create(tagger_id: category.id, tagger_type: "Category", tagged_id: self.id, tagged_type: "Pick")
                    end
                end
            end
        end
    end

    def link_hashtags_to_categories
        if self.status == "published" && self.hashtags.take && self.categories.take
            self.hashtags.each do |hashtag|
                self.categories.each do |category|
                    Tag.create(tagger_id: category.id, tagger_type: "Category", tagged_id: hashtag.id, tagged_type: "Hashtag")
                end
            end
        end
    end

    # def content
    #     body[0..550].gsub(/s*$/, '...')
    # end

    # def check_user_campaigns
    # 	if self.products.take || self.brands.take
    		
    # 	end
    # end

end
