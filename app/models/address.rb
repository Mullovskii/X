class Address < ApplicationRecord
  belongs_to :country
  belongs_to :city
  belongs_to :street
  belongs_to :owner, polymorphic: true
  enum kind: [:offline_store, :pick_up_point]
end
