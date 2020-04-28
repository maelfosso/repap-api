class Hotel < ApplicationRecord
  belongs_to :user

  has_many_attached :photos

  validates :name, presence: true
  validates :phone, presence: true 
  validates :price, presence: true
  validates :address, presence: true
  validates :latlng, presence: true
  
  validates :user, presence: true
end
