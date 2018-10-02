module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :set_relationship, only: [:show, :update, :destroy]
      before_action :authenticate_request!, only: [:update, :create]


      # POST /relationships
      def create
        @relationship = current_user.active_relationships.build(relationship_params.merge({follower_id: current_user.id, follower_type: current_user.class.to_s }))
        if @relationship.save
          render json: @relationship, status: :created
        else
          render json: @relationship.errors, status: :unprocessable_entity
        end
      end
     
      # DELETE /relationships/1
      def destroy
        if current_user == @relationship.follower
          @relationship.destroy  
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_relationship
          @relationship = Relationship.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def relationship_params
          params.require(:relationship).permit(:followed_id, :followed_type)
        end
    end
  end
end
