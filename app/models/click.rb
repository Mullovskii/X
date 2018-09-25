class Click < ApplicationRecord
	
	belongs_to :user
	belongs_to :pick
	belongs_to :link
	has_one :operation, class_name: "Transaction", foreign_key: "click_id"
	after_create :add_points
	after_update :add_points_for_product
	before_destroy :reverse_transaction
	 
	
	enum status: [:off, :on]

	def authentic
		unless Click.where(link_id: self.link_id, user_id: self.user_id).take
			true
		end
	end

	def valid
		self.link.campaign
	end

	def self_made
		if self.user_id == self.pick.author_id
			false
		else
			true
		end
	end

	def reverse_transaction
		self.operation.destroy if self.operation
	end

	def add_points
		if self.status == "on"
			Transaction.create(debit_account: self.link.campaign.account, credit_account: self.link.linking.author.accounts.where(currency_id: self.link.campaign.account.currency_id).take, amount: self.link.campaign.currency_per_referral, currency_id: self.link.campaign.currency_id, kind: "reward", click_id: self.id)
			Notification.create(notified_id: self.pick.author_id, notified_type: "User", notifier_id: self.user_id, notifier_type: "User", kind: "reward", attached_id: self.link_id, attached_type: "Link", amount: self.operation.amount, currency_id: self.operation.currency_id)
		end
	end

	

	def add_points_for_product
		if self.saved_change_to_status? && self.status == "on"
			unless self.operation
				Transaction.create(debit_account: self.link.campaign.account, credit_account: self.link.linking.author.accounts.where(currency_id: self.link.campaign.account.currency_id).take, amount: self.link.campaign.currency_per_referral, currency_id: self.link.campaign.currency_id, kind: "reward", click_id: self.id)
				Notification.create(notified_id: self.pick.author_id, notified_type: "User", notifier_id: self.user_id, notifier_type: "User", kind: "reward", attached_id: self.link_id, attached_type: "Link", amount: self.operation.amount, currency_id: self.operation.currency_id)
			end
		end
	end

end
