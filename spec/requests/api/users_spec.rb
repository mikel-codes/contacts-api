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
     before do
       post "/api/user/signup", params: valid_params
     end
     it 'creates a new user' do
       expect(response).to have_http_status :created
     end
   end
  end
end
