class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :name, :target, :reward, :status, :bonus_per_click, :currency_id, :read_user_data, :followers_threshold, :link_1, :link_2, :link_3, :link_4, :link_5, :label_1, :label_2, :label_3, :product_target
end
