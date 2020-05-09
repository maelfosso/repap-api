class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password

  has_many :hotels

  has_many :favorites
  has_many :favorite_hotels, :through => :favorites, :source => :hotels

  def payload
    return {
      email: self.email,
      phone: self.phone,
      name: self.name
    }
  end 
end
