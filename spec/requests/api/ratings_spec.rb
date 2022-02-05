require 'rails_helper'

RSpec.describe "Api::Ratings", type: :request do
  describe do

    let(:user) { create(:user) }
    let(:headers) { {"Authorization": "JWT #{JsonWebToken.encode(user_id: user.id)}"}}
    let!(:contacts) do
        build_list(:contact, 10, owner: user).each_with_index do |contact, i|
        contact.phone = Faker::PhoneNumber.cell_phone_in_e164.slice(0,9) + i.to_s
        contact.save!
      end
    end
    let(:contact_id) { contacts.first.id }

    describe "POST /create" do
      it "returns http success" do
        expect{ post "/api/contacts/#{contact_id}/ratings", params: {value: 2}, headers: headers}.to change{ Rating.count }.by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
=begin
    describe "GET /update" do
      it "returns http success" do
        get "/rating/update"
        expect(response).to have_http_status(:success)
      end
    end
=end
