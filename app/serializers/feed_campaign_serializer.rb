class FeedCampaignSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :feed
  has_one :campaign
end
