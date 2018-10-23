module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_request!, only: [:update, :create, :destroy, :accounts, :feed, :user_addresses]
      before_action :set_user, only: [:accounts, :showroom]
      before_action :set_username, only: [:show]
      
      def index
        @users = User.all 
        render json: @users, meta: default_meta, include: [params[:include]]
      end

      def show  
        render json: @user, meta: default_meta, include: [params[:include]]
      end

      def feed
        picks = []
        current_user.following.each do |user|
          user.picks.each do |pick|
            picks << pick
          end
        end
        picks = picks.sort_by{:created_at} if picks
        render json: picks, meta: default_meta, include: [params[:include]]
      end

      def accounts
        if current_user == @user
          render json: @user.accounts, meta: default_meta, include: [params[:include]]
        else 
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      def user_addresses
        render json: current_user.addresses, meta: default_meta, include: [params[:include]]
      end

      def showroom
        render json: @user.showroom.products, meta: default_meta, include: [params[:include]]
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        def set_username
          @user = User.find_by_username(params[:username])
        end
    

    end
  end
end