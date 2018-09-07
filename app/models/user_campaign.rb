class UserCampaign < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  belongs_to :link
  belongs_to :gift, optional: true
  enum status: [:on, :off]
end
