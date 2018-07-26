class AuthenticationController < ApplicationController
  before_action :authenticate_request!, only: :get_user
  
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user
      if user.valid_password?(params[:user][:password])
        render json: payload(user)
      else
        render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
      end
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def get_user
    render json: payload(current_user)
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email, name: user.username, role: user.role}
    }
  end

end