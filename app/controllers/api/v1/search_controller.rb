module Api
  module V1
		class SearchController < ApplicationController
			def index
			   if params[:query].present?
			     @hashtags = Hashtag.search(params[:query])
			   else
			     @hashtags = Hashtag.all
			   end
			   render json: @hashtags
			 end
		end
	end
end