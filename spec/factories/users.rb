FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6, max_length: 10)
    password  { password }
    #firstname { Faker::Internet.lastnam }
    #lastname  { Faker::Internet.last_name  }
  end
end
