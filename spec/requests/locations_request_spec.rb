# require 'rails_helper'
#
# RSpec.describe 'Locations', type: :request do
#
#   let(:user) { FactoryBot.create(:user) }
#   let(:location) { FactoryBot.create(:location, user_id: user.id) }
#
#   describe 'GET /locations' do
#     it 'redirect unauthorized user' do
#       get '/locations'
#       expect(response.body).to include('redirected')
#     end
#
#     it 'success for authorized user' do
#       user = FactoryBot.create(:user)
#       login_as(user)
#       get '/locations'
#       expect(response.status).to be 200
#     end
#   end
#
#   describe 'GET /locations/:id' do
#     it do
#       user = FactoryBot.create(:user)
#       location = FactoryBot.create(:location, user_id: user.id)
#       login_as(user)
#       get "/locations/#{location.id}"
#
#       expect(json['location'].first['user_id']).to be user.id
#     end
#   end
#   # describe 'POST /locations/:id' do
#   #
#   # end
#   #
#   #
#   # context 'when request attributes are valid' do
#   #   before do
#   #     post '/locations', params: valid_attributes
#   #
#   #     let(:valid_attributes) do
#   #       { title: 'Whispers of Time', author: 'Dr. Krishna Saksena',
#   #         category_id: history.id }
#   #     end
#   #   end
#   #   context 'when an invalid request' do
#   #     before do
#   #       post '/locations', params: {}
#   #     end
#   #
#   #   end
#   # end
#   # describe 'PUT /books/:id' do
#   #
#   #   before do
#   #     put "/locations/#{book_id}", params: valid_attributes
#   #   end
#   #
#   # end
#   # describe 'DELETE /books/:id' do
#   #   before do
#   #     delete "/locations/#{book_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }
#   #   end
#   #
#   # end
# end
