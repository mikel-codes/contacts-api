require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { is_expected.to validate_presence_of(:contact) }
  it { is_expected.to validate_inclusion_of(:value).in_range(1..5) }
end
