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

     it 'increases the number of created user by 1' do
       expect { post "/api/user/signup", params: valid_params }.to change{User.count}.by(1)
       expect(response).to have_http_status :created
     end
   end
  end
end
