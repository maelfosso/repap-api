class ApplicationController < ActionController::API
  include Response

  before_action :require_login

  def encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, 'repap-api')
  end

  def session_user
    decoded_hash = decoded_token
    return if decoded_hash.empty?

    email = decoded_hash[0]['email']
    @current_user = User.find_by(email: email)
  end

  def logged_in?
    !session_user.nil?
  end

  def require_login
    return if logged_in?

    render json: {
      message: 'Please login'
    }, status: :unauthorized
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, 'repap-api', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      []
    end
  end
end
