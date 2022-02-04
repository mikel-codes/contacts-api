FactoryBot.define do
  factory :contact do
    user { create(:user) }
    name { Faker::Name.name }
    phone { '909239333' }
    description { "Example: Yea mu description" }
  end
end
