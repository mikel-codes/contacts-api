class Rating < ApplicationRecord
  belongs_to :contact
  validates :contact, presence: true
  validates :value, inclusion: { in: 1..5 }
end
