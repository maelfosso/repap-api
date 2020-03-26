class ApplicationController < ActionController::API
  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      email = decoded_hash[0]['email']
      @user = User.find_by(email: email)
    else 
      nil
    end
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end
end
