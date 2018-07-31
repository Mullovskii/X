class UserCampaignSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :user
  has_one :campaign
end
