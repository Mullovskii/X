class FeedSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :mode, :format, :target_country_id, :content_language, :currency, :name, :input_type, :url, :author_id, :author_type
end
