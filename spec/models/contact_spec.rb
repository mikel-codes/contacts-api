require 'rails_helper'
RSpec.describe Contact, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:phone) }


  describe 'phone' do
    let(:contact) { build(:contact) }

    describe 'when phone number is valid' do
      it 'is valid' do
        contact.phone = '(555) 555-5555'
        expect(contact).to be_valid
      end
    end

    describe 'when phone number is too short' do
      it 'is not valid' do
        contact = build(:contact, phone: '123')
        contact.valid?
        expect(contact.errors[:phone]).to include('is invalid')
      end
    end

    describe 'when phone number is all letters' do
      it 'is not valid' do
        contact.phone = '(AAA) AAA-AAAA'
        contact.valid?
        expect(contact.errors[:phone]).to include('is invalid')
      end
    end
  end
end
