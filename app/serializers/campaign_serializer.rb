class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :name, :kind, :mode, :status, :bid_per_action, :currency_id, :actions_per_gift, :read_user_data, :gift_id, :followers_threshold, :actions_per_gift, :link_1, :link_2, :link_3, :link_4, :link_5
end
