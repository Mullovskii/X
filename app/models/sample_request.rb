class SampleRequest < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :shop

  enum status: [:pending, :approved, :delivered, :fraud_detected]
  enum kind: [:user_request, :shop_request]
  validates :user_id, uniqueness: { scope: [:product_id] }

  after_update :approved_status

  def approved_status
    if self.saved_change_to_shop_approval? && self.shop_approval == true && self.user_approval == true || self.saved_change_to_user_approval? && self.shop_approval == true && self.user_approval == true
      self.update(status: "approved")
      generate_order
    end
  end

  def generate_order
  		Order.where(product_id: self.product_id, user_id: self.user_id, shop_id: self.shop_id, kind: "sample_product").first_or_create
  end
end
