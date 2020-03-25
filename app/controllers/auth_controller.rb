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
  end

  def logout
  end

  def auto_login
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
