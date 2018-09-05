class FeedSerializer < ActiveModel::Serializer
  attributes :id, :mode, :kind, :delivery_id, :shop_id, :format, :country_id, :currency_id, :name, :url, :author_id, :author_type, :gift_mode
end
