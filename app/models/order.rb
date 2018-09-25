class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :ordered, polymorphic: true
  has_many :transactions, dependent: :destroy
  has_one :operation, class_name: "Transaction", foreign_key: "order_id"

  enum status: [:pending, :authorized, :fulfilled, :cancelled]
  enum kind: [:product, :gift, :coupon, :sample, :campaign_topup]


  after_create :authorize_order


  def authorize_order
  	if self.shop.integration_type == "manual"
  		self.update(status: "authorized", confirmed_at: Time.now)
  		unless self.kind == "sample"
  			Transaction.create(account_id: self.user.accounts.where(shop_id: self.shop.id).take.id, order_id: self.id, purchased_id: self.ordered_id, purchased_type: self.ordered_type, amount: self.amount)	
  		end
  	end
  end

end
