module Api
  module V1
    class RegistrationsController < ApplicationController
    # class RegistrationsController < Devise::RegistrationsController

      before_action :set_user, only: [:update]
      before_action :authenticate_request!, only: [:update]

      def create
        user = User.new(user_params)
        if user.save
          render json: payload(user), status: :created
        else
          # render_error(user, :unprocessable_entity)
          render json: {errors: ['User with this email already exists']}, status: :unauthorized
        end
      end

      def update
        if current_user == @user
          if @user.update_attributes(user_params)
            render json: @user, status: :ok
          else
            render_error(@user, :unprocessable_entity)
          end
        else
          render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
        end

      end

      # private
      #   # Use callbacks to share common setup or constraints between actions.
      def set_user
        begin
          @user = User.find(params[:user][:id])
        rescue ActiveRecord::RecordNotFound
          user = User.new
          user.errors.add(:id, 'Wrong ID provided')
          render_error(user, 404) and return
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :full_name, :email, :role, :password, :password_confirmation, :phone, :phone_verified, :description, :instagram, :twitch, :facebook, :sex, :avatar, :background, :country_id)
      end

      def payload(user)
        return nil unless user and user.id
        {
            auth_token: JsonWebToken.encode({user_id: user.id}),
            user: {id: user.id, email: user.email, username: user.username, full_name: user.full_name, role: user.role}
        }
      end

    end
  end
end 

