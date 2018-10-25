class Shipping < ApplicationRecord
  belongs_to :shop
  belongs_to :order
  belongs_to :dispute, optional: true
  validates :tracking_number, presence: true, uniqueness: true
  after_create :check_tracking_number, :dispute_status_wait
  after_update :add_confirmation, :order_status_delivered, :dispute_status_refund

  enum status: [:unverified, :wrong_tracking_number, :in_delivery, :delivered, :lost]
  enum provider: [:pochta_rossii]
  enum kind: [:purchase_delivery, :refund_delivery]

  def check_tracking_number
  	#ходим за проверкой tracking_number к агрегатору доставок или напрямую к доставщику в зависимости от провайдера
  	if true
  		self.update(status: "in_delivery")
  	else
  		self.update(status: "wrong_tracking_number")
  	end
  end

  def dispute_status_wait
  	unless self.dispute_id.nil?
  		self.dispute.update(status: "wait_delivery_confirmation")
  	end
  end

  def add_confirmation
  	if self.saved_change_to_surf_delivery_confirmation? && self.surf_delivery_confirmation == true || self.saved_change_to_user_delivery_confirmation? && self.user_delivery_confirmation == true 
  		self.update(status: "delivered")
  	end
  end

  def order_status_delivered
  	if self.saved_change_to_status? && self.status == "delivered"
  		self.update(delivered_at: DateTime.now)
  		self.order.update(status: "delivered", delivered_at: DateTime.now)
  		#добавить логику с уведомлением пользователя
  	end
  end

  def dispute_status_refund
  	if self.kind == "refund_delivery" 
  		if self.saved_change_to_shop_delivery_confirmation && self.shop_delivery_confirmation == true
  			self.update(status: "delivered", delivered_at: DateTime.now)
  			self.order.dispute.update(status: "refund_approved")
  		end
  		#добавить логику с уведомлением пользователя
  	end
  end

  
end
