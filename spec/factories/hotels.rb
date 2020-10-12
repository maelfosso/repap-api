FactoryBot.define do 
  factory :hotel do

    name { Faker::Name.name }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number }
    latlng { "#{Faker::Address.latitude}, #{Faker::Address.longitude}" }
    price { Faker::Commerce.price }
    
  end
end