class Employment < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  enum role: [:admin, :editor]
  enum status: [:requested, :declined, :approved]
end
