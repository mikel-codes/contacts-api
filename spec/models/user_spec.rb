require 'rails_helper'
require 'byebug'
RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive}
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(10) }
  it { should validate_confirmation_of(:password) } # NEW

  #let user =  create(:user, email: "IoXT@email.com").save()
end
