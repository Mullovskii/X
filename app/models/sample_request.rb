class SampleRequest < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :shop

  enum status: [:pending, :approved]
  enum kind: [:user_request, :shop_request]

  after_update :generate_order

  def generate_order
  	if self.shop_approval == true && self.user_approval == true
  		unless Order.where(ordered_id: self.product_id, ordered_type: "Product", user_id: self.user_id, shop_id: self.shop_id).take
  			Order.create(ordered_id: self.product_id, ordered_type: "Product", user_id: self.user_id, shop_id: self.shop_id, kind: "sample")
  		end
  	end
  end
end
