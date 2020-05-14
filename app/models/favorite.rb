class Favorite < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :hotel, inverse_of: :favorites

  def as_json(_opts = {})
    {
      id: hotel.id,
      name: hotel.name,
      phone: hotel.phone,
      price: hotel.price,
      address: hotel.address,
      infos: hotel.infos,
      latlng: hotel.latlng,
      website: hotel.website,
      url: hotel.url,
      rating: hotel.rating,
      errors: errors,
      photos: hotel.photos.map do |photo|
        {
          url: rails_blob_url(photo, only_path: true),
          id: photo.id
        }
      end,
      favorite: id
    }
  end
end
