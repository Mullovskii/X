class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :status, :name, :country_id, :kind, :link_referral, :link_1, :link_2, :link_3, :link_4, :link_5, :points_per_referral, :product_tagging, :currency_per_referral, :currency_id, :campaign_products, :label_1, :label_2, :label_3
  has_many :ads_products
end
