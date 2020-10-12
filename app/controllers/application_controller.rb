class ApplicationController < ActionController::API
  include Response
  
  before_action :require_login

  def encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, "repap-api")
  end
  
  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      email = decoded_hash[0]['email']
      @current_user = User.find_by(email: email)
    else 
      nil
    end
  end

  def logged_in?
    !!session_user
  end

  def require_login
    render json: {
      message: 'Please login'
    }, status: :unauthorized unless logged_in?
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'repap-api', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end
end
