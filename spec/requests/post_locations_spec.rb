# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST Locations', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:location) { FactoryBot.build(:location) }

  describe '/create' do
    context 'with valid parameters' do
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

      it 'returns name' do
        expect(json['name']).to eq(location.name)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        login_as(user)
        post '/locations', params: { location: {} }
      end

      it 'returns a unprocessable entity status' do
        expect(response.status).to eq 422
      end
    end
  end
end
