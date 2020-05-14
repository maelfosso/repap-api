module ControllerSpecHelper 
  def token_generator(user)
    "Bearer " + JWT.encode({
      email: user.email,
      phone: user.phone,
      name: user.name
    }, "repap-api")
  end

  def expired_token_generator(user)
    JWT.encode({
      email: user.email,
      phone: user.phone,
      name: user.name
    }, "repap-api", (Time.now.to_i - 10))
  end

  def valid_headers
    {
      "Authorization" => token_generator(user.id),
      "Content-Type" => "application/json"
    }
  end

  def invalid_headers
    {
      "Authorization" => nil,
      "Content-Type" => "application/json"
    }
  end

end