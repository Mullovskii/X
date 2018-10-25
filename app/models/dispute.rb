class Dispute < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  belongs_to :order
  has_one :shipping
  belongs_to :address, optional: true
  validates :order_id, uniqueness: true, presence: true

  enum reason: [:no_delivery, :wrong_color, :wrong_size, :wrong_material, :defects, :counterfeit]
  enum status: [:wait_shop_agreement, :wait_tracking, :wait_delivery_confirmation, :refund_approved]

  after_update :status_update, :generate_refund

  def status_update
  	if self.saved_change_to_shop_agreement && self.shop_agreement == true
  		self.status = "wait_tracking"
  		self.save
  	end
  end

  def generate_refund
  	if self.saved_change_to_status && self.status == "refund_approved"
  		self.order.update(status: "user_refunded", refunded_at: Time.now)
  	end
  end

end
