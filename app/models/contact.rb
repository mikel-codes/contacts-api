class Contact < ApplicationRecord
  #the ORM maps the user to owner so api calls can be cloaked with owner instead
  has_many :ratings,  :dependent => :destroy
  belongs_to :owner, class_name: "User", foreign_key: :user_id

  validates :phone, :name, presence: true
  validates :name, length: { minimum: 4}
  validates :phone, format: {with: /\A(\+\d{1,2}\s?)?\(?\d{2,3}\)?[\s.-]?\d{2,3}[\s.-]?\d{3,4}\z/ }, uniqueness: true

  def as_json(options={})
    super(options.merge(include: :ratings))
  end
end
