require 'rails_helper'
require 'byebug'
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
    let!(:rating) { create(:rating, contact: contacts.first, value: 4) }
    let(:contact_id) { contacts.first.id }

    describe "POST /create" do
      it "returns http success" do
        expect{ post "/api/contacts/#{contact_id}/ratings", params: {value: 5}, headers: headers}.to change{ Rating.count }.by(1)
        expect(response).to have_http_status(:created)
        expect(Rating.count).to eql(2)
      end
    end

    describe "PUT /update" do
      it "returns http success" do
        expect { put "/api/contacts/#{contact_id}/ratings/#{rating.id}", params: {value: 3}, headers: headers }.to change{ Rating.count }.by(0)
        expect(response).to have_http_status(:success)
        res = JSON.parse(response.body)
        expect(res["value"]).to eql(3)
        expect(Rating.count).to eql(1)
      end
    end
  end
end
