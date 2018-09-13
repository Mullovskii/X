class Gift < ApplicationRecord
  belongs_to :shop
  belongs_to :feed, optional: true
  belongs_to :country

  has_many :user_campaigns

  enum status: [:on, :off]

  def gift_mode
    true
  end

end
