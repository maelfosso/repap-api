class Hotel < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many_attached :photos
  has_many :favorites, inverse_of: :hotel

  validates :name, presence: true
  validates :phone, presence: true
  validates :price, presence: true
  validates :address, presence: true
  validates :latlng, presence: true

  validates :user, presence: true

  def as_json(_opts = {})
    {
      id: id,
      name: name,
      phone: phone,
      price: price,
      address: address,
      infos: infos,
      latlng: latlng,
      website: website,
      url: url,
      rating: rating,
      errors: errors,
      photos: photos.map do |photo|
        {
          url: rails_blob_url(photo, only_path: true),
          id: photo.id
        }
      end,
      favorite: !favorites.empty? ? favorites.first.id : false
    }
  end
end
