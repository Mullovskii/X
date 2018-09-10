class Address < ApplicationRecord
  belongs_to :country
  belongs_to :city
  belongs_to :street
  belongs_to :owner, polymorphic: true
end
