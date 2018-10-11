module Api
  module V1
		class SearchController < ApplicationController
			def index
			   if params[:hashtag].present?
			     	query = PgSearch.multisearch(params[:hashtag]).where(:searchable_type => "Hashtag")
			   elsif params[:user].present?
			   		query = PgSearch.multisearch(params[:user]).where(:searchable_type => "User")
			   elsif params[:brand].present?
			   		query = PgSearch.multisearch(params[:brand]).where(:searchable_type => "Brand")
			   else
			     query = Pick.all
			   end
			    query = query.page(params[:page]).per(10)
          	 	# render json: query, meta: pagination_meta(query).merge(default_meta), include: [params[:include]]
          	 	render json: query
			 end
		end
	end
end