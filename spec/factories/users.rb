FactoryBot.define do 
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    password "repap-api-1"
    password_confirmation "repap-api-1"
  end
end