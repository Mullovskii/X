class UserCampaign < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  enum status: [:off, :on]
end
