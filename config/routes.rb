Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/auth/registration",  to: "auth#registration"
  post "/auth/login",         to: "auth#login"
  post "/auth/logout",        to: "auth#logout"

  get "/auth/auto_login",     to: "auth#auto_login"
  get "auth/user_is_authed",  to: "auth#user_is_authed"

  post "/hotels",             to: "hotels#create"
end
