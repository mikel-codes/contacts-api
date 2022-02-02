class User < ApplicationRecord
  #adds security enrcyption  hashing by bcrypt
  has_secure_password

  #will convert email mixedcase letters to lowercase on save
  before_save { self.email.downcase! unless self.email.blank? }

  #validations for the required fields
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :password_digest, presence: true
  validates :password, length: {minimum: 6, maximum: 10}
end
