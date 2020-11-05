FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    password { 'repap-api-1' }
    password_confirmation { 'repap-api-1' }
  end
end
