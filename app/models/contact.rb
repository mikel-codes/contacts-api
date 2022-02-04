class Contact < ApplicationRecord
  belongs_to :user
  validates :phone, :name, presence: true
  validates :name, length: { minimum: 4}
  validates :phone, format: {with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/}
end
