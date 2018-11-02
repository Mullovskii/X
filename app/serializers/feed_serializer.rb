class FeedSerializer < ActiveModel::Serializer
  attributes :id, :shop_id, :format, :url, :sample_mode, :sample_threshold
end
