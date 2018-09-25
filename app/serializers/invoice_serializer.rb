class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :payment_method, :amount, :custom_id, :status, :vat, :campaign_id
  has_one :account
  has_one :shop
end

