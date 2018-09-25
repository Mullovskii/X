class Account < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :campaign, optional: true
  belongs_to :shop, optional: true
  belongs_to :currency, optional: true
  has_many :debit_transactions, class_name: "Transaction", foreign_key: "debit_account_id"
  has_many :credit_transactions, class_name: "Transaction", foreign_key: "credit_account_id"

  enum kind: ["money", "virtual"]

end
