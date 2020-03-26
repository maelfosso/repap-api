class AuthController < ApplicationController
  def registration
    user = User.create(registration_params)
    if user.valid?
      token = encode_token(user.payload)
      render json: {
        user: user,
        jwt: token
      }
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :not_acceptable
    end
  end

  def login
    user = User.find_by(email: params[:username]) || User.find_by(phone: params[:username])
    if user && user.authenticate(params[:password])
      token = encode_token(user.payload)
      render json: {
        user: user,
        jwt: token
      }
    else 
      render json: {
        failure: "Log in failed! Username or password invalid!"
      }, status: :not_acceptable
    end
  end

  def logout
  end

  def auto_login
    if session_user
      render json: session_user
    else 
      render json: {
        errors: "No user logged in"
      }
    end 
  end

  def user_is_authed
  end

  private

  def registration_params
    params.require(:auth).permit(:email, :phone, :name, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, "repap-api")
  end

end
