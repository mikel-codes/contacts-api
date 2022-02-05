FactoryBot.define do
  factory :contact do
    owner { create(:user) }
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.phone_number }
    description { "Example: Yea mu description" }
  end
end
