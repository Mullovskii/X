class Shop < ApplicationRecord
	belongs_to :owner, polymorphic: true
	enum status: [:brand_owned, :user_owned, :marketplace]
	enum kyc: [:new, :unverified, :in_progress, :verified]
end
