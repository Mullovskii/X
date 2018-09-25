class UserCampaign < ApplicationRecord
  belongs_to :user
  belongs_to :campaign
  belongs_to :link
  enum status: [:on, :off]

  after_create :generate_account

  def generate_account
  	# unless self.user.accounts.where(shop_id: self.campaign.shop.id).take
  	# 	Account.create(user_id: self.user.id, shop_id: self.campaign.shop.id)
  	# end
    unless self.user.accounts.where(currency_id: self.campaign.account.currency_id).take
      self.user.accounts.create(currency_id: self.campaign.account.currency_id)
    end
  end
end
