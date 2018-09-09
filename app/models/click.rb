class Click < ApplicationRecord
	
	belongs_to :user
	belongs_to :pick
	belongs_to :link
	after_create :add_points

	enum status: [:off, :on]

	def authentic
		unless Click.where(link_id: self.link_id, user_id: self.user_id).take
			true
		end
	end

	def valid
		self.link.campaign
	end

	def add_points
		if self.status == "on"
			account = self.link.linking.author.accounts.where(shop_id: self.link.campaign.shop.id).take 
			account.balance += self.link.campaign.points_per_referral
			account.save
		end
	end

end
