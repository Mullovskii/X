class Address < ApplicationRecord
  belongs_to :country
  belongs_to :city, optional: true
  belongs_to :street, optional: true
  belongs_to :owner, polymorphic: true
  enum kind: [:offline_store, :pick_up_point]

  after_create :add_city, :add_street

  def add_city
  	city = City.where(name: self.city_name, country_id: self.country_id).first_or_create
  	self.city_id = city.id
  	self.save
  end

  def add_street
  	street = Street.where(name: self.street_name, city_id: self.city_id).first_or_create
  	self.street_id = street.id
  	self.save
  end
  
end
