class FeedCampaign < ApplicationRecord
  belongs_to :feed
  belongs_to :campaign
end
