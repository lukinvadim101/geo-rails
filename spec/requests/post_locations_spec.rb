
require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:location) { FactoryBot.build(:location) }

      before do
        login_as(user)
        post '/locations', params:
          { location: {
            name: location.name,
            user_id: user.id,
            latitude: location.latitude,
            longitude: location.longitude
          } }
      end

      it 'returns the title' do
        expect(json['name']).to eq(location.name)
      end

      it 'returns the content' do
        expect(json['longitude']).to eq(location.longitude)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end
  #
    context 'with invalid parameters' do
      let!(:user) { FactoryBot.create(:user) }
      before do

        login_as(user)
        post '/locations', params: { location: {} }
      end

      it 'returns a unprocessable entity status' do
        # binding.pry
        expect(response.status).to eq 422
      end
    end
  end
end
