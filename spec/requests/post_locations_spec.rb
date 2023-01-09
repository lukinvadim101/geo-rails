# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST Locations', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:location) { FactoryBot.build(:location) }
  let(:valid_attributes) do
    {
      location: { name: location.name,
                  user_id: user.id,
                  latitude: location.latitude,
                  longitude: location.longitude }
    }
  end

  let(:invalid_attributes) do
    {
      location: { name: nil,
                  user_id: nil,
                  latitude: 9999,
                  longitude: -500 }
    }
  end

  describe 'create' do
    before do
      login_as(user)
    end
    context 'with valid parameters' do
      before do
        post '/locations', params: valid_attributes
      end

      it 'returns correct attribute' do
        expect(json['name']).to eq(location.name)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns error message' do
        post '/locations', params: invalid_attributes
        expect(json['message']).to include('Validation failed')
      end
    end
  end
end
