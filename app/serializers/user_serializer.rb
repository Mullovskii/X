class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email, :role, :phone, :description, :instagram, :twitch, :facebook
	
end