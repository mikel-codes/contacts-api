class User < ApplicationRecord
  #adds security enrcyption  hashing by bcrypt
  has_secure_password
  has_many :contacts
  #will convert email mixedcase letters to lowercase on save
  before_save { self.email.downcase! unless self.email.blank? }

  #validations for the required fields
  validates :email, uniqueness: { case_sensitive: false }, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true
  validates :password, presence: true, length: {minimum: 6, maximum: 10}
end
