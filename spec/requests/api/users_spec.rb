require 'rails_helper'
require 'byebug'

RSpec.describe "Users", type: :request do
  describe "POST /api/user/signup" do
   context "with valid parameters" do
     let(:valid_params) do
       {
         user: {
         first_name: 'John',
         last_name: 'Doe',
         email: 'johndoe@example.com',
         password: 'password'
       }
       }
     end

     it 'increases the number of created user by 1 and checks response code' do
       expect { post "/api/user/signup", params: valid_params }.to change{User.count}.by(1)
       expect(response).to have_http_status :created
     end
   end
 end


  describe "POST /api/user/signin User Login" do
    let(:user) { create(:user)}

    #set the invalid and valid login credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end
    let(:signin_url) { '/api/user/signin' }
    let(:token) { JWT.encode(user) }

    #let(:headers) { valid_headers.except('Authorization') }

    context "with valid_params" do
      before do
        post signin_url, params: valid_credentials
      end
      it "should login in the user with a status code 200" do
        res = JSON.parse(response.body)
        expect(response).to have_http_status 200
        expect(res['message']).to match(/logged in successfully/)
        expect(res['token']).not_to be nil
        expect(res['user']).not_to be nil
      end
    end

    context 'When request is invalid' do
      before { post signin_url, params: invalid_credentials }
      it 'returns a failure message' do
        expect(response.body).to match(/Invalid credentials/)
        expect(response).to have_http_status :bad_request
      end
    end
  end
end
