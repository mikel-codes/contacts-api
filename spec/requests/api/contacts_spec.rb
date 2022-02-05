require 'rails_helper'
require 'byebug'
RSpec.describe "Api::Contacts Endpoints", type: :request do
  describe   do
    let(:user) { create(:user) }
    let(:headers) { {"Authorization": "JWT #{JsonWebToken.encode(user_id: user.id)}"}}
    let!(:contacts) do
        build_list(:contact, 10, owner: user).each_with_index do |contact, i|
        contact.phone = Faker::PhoneNumber.cell_phone_in_e164.slice(0,9) + i.to_s
        contact.save!
      end
    end
    describe "index" do
      describe "GET /index" do
        context "with valid authorization headers" do
          it "returns http success" do
            get "/api/contacts", params: {}, headers: headers
            res = JSON.parse(response.body)
            expect(response).to have_http_status(:success)
            expect(Contact.count).to eql 10
            byebug
          end
        end
      end

      describe "GET /index" do
        context "with invalid authorization headers" do
          it "returns a nil user and raises a 404" do
            get "/api/contacts", params: {}, headers: {"Authorization": "JWT bdJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo1LCJleHAiOjE2NDkyMDU2Njl9.rlmaazxz26HV7a1dqHqbfJaiwCXCLM"}
            expect(response).to have_http_status(:unauthorized)
            expect(response.body).to be_empty
          end
        end
      end
    end

    describe "show" do
      describe "GET /show" do
        context "with valid headers" do
          it "returns http success" do
            get "/api/contacts/#{Contact.first.id}", params: {}, headers: headers
            expect(response).to have_http_status(:success)
          end
        end
      end
    end

    describe "create" do
      describe "POST /create" do
        context "with valid params and already authorized" do
          let(:valid_params)  {
            {
              name: "Joo Inn",
              phone: "+72373902738",
              description: "No place like home"
            }
          }
          it "creates an instance of Contact" do
            expect { post "/api/contacts", params: valid_params, headers: headers}.to change { Contact.count }.by(1)
            expect(response).to have_http_status(:created)
            res = JSON.parse(response.body)
            expect(res["name"]).to eq("Joo Inn")
            expect(res["user_id"]).to eq(user.id)
          end
        end

        context "with invalid params" do
          let(:invalid_params)  {
            {
              name: "Jddx",
              phone: "+72373xzm",
              description: ""
            }
          }
          it "creates an instance of Contact" do
            expect { post "/api/contacts", params: invalid_params, headers: headers}.to change { Contact.count }.by(0)
            expect(response).to have_http_status(:bad_request)
          end
        end
      end
    end
  end
end


=begin
  describe "GET /update" do
    it "returns http success" do
      get "/api/contacts/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/contacts/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/api/contacts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create:post" do
    it "returns http success" do
      get "/api/contacts/create:post"
      expect(response).to have_http_status(:success)
    end
  end
=end
