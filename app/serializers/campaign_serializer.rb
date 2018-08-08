class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :name, :kind, :mode, :status, :bid_per_action, :currency_id, :read_user_data, :followers_threshold, :link_1, :link_2, :link_3, :link_4, :link_5
end
