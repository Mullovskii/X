class ApplicationController < ActionController::API

# before_action :authenticate_request!
# before_action :check_header
#jwt
    attr_reader :current_user
#jwt

def default_meta
    {
      api_version: 'v1',
      licence: 'CC-0',
      authors: ['Surf 2018']
    }
 end


 #jwt
  protected

  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

#jwt


  private
#jwt
	def http_token
	     @http_token ||= if request.headers['Authorization'].present?
	        request.headers['Authorization'].split(' ').last
	     end
	end

	  def auth_token
	    @auth_token ||= JsonWebToken.decode(http_token)
	  end

	  def user_id_in_token?
	    http_token && auth_token && JsonWebToken.valid_payload(auth_token) && auth_token[:user_id].to_i
	  end
#jwt


  def render_error(resource, status)
    render json: resource, status: status, adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def record_not_found(message)
    render :json => {:error => message}, :status => :not_found
  end

  def check_header
    if ['POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/vnd.api+json"
        head 406
      end
    end
  end

  def validate_type
    if params['data'] && params['data']['type']
      if params['data']['type'] == params[:controller]
        return true
      end
    end
    head 409
  end

end
