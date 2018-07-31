class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :name, :kind, :mode, :status, :bid_per_action, :currency_id, :actions_per_gift, :gift_id, :followers_threshold, :actions_per_gift
end
