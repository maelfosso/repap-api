class Hotel < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_many_attached :photos

  validates :name, presence: true
  validates :phone, presence: true 
  validates :price, presence: true
  validates :address, presence: true
  validates :latlng, presence: true
  validates :website, presence: true 
  
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
      errors: errors,
      photos: photos.map do |photo|
        {
          url: rails_blob_url(photo, only_path: true),
          id: photo.id
        }
      end
    }
  end

end
