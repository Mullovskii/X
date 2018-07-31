class EmploymentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :role, :status
  has_one :user
  has_one :shop
end
