# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

API_KEY = 'AIzaSyBHaVnhN3gSB5otSpmKqutxuMaL878KItY'

alice = User.create!(
  :name => "Alice Bar",
  :email => "alice.bar@repap.com",
  :phone => "+23769520125",
  :password => "alicebar",
  :password_confirmation => "alicebar"
)
bob = User.create!(
  :name => "Bob Bar",
  :email => "bob.bar@repap.com",
  :phone => "+23769520125",
  :password => "bobbar",
  :password_confirmation => "bobbar"
)


path = File.join(File.dirname(__FILE__), "./hotels.json")
records = JSON.parse(File.read(path))
records.each do |record|
  hotel = Hotel.create(
    :name => record["name"],
    :address => record["address"],
    :phone => record["phone"].empty? ? Faker::PhoneNumber.phone_number : record["phone"],
    :latlng => record["latlng"],
    :price => Faker::Commerce.price,
    :website => record["website"],
    :url => record["url"],
    :rating => record["rating"],

    :user => [alice, bob].sample
  )

  doit = [true, false].sample
  if doit
    Favorite.create!(:user => alice, :hotel => hotel)
  end
  doit = [true, false].sample
  if doit
    Favorite.create!(:user => bob, :hotel => hotel)
  end

  record["photos"].each do |photo|
    url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=#{photo["width"]}&photoreference=#{photo["photo_reference"]}&key=#{API_KEY}"
    download = open(url)

    hotel.photos.attach(io: download, filename: Faker::File.file_name(ext: "jpg"))
    hotel.save! 
  end
end
