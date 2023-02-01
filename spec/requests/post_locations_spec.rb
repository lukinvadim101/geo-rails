# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Api::LocationsController, type: :request do
  describe 'when authenticated user' do
    let(:user) { FactoryBot.create(:user) }
    let(:location) { FactoryBot.create(:location, user_id: user.id) }
    let(:valid_attributes) { attributes_for(:location) }

    describe 'POST create' do
      context 'with valid parameters' do
        let(:valid_attributes) { attributes_for(:location) }

        before do
          login_as(user)
          post '/api/locations', params: { location: valid_attributes }
        end

        it 'returns correct attribute' do
          expect(json['data']['attributes']['name']).to eq(location.name)
        end

        it 'returns status ok' do
          expect(response).to have_http_status('200')
        end
      end

      context 'when invalid parameters' do
        it 'returns error message' do
          login_as(user)
          post '/api/locations', params: {
            location: { name: nil }
          }
          expect(json['error']).to include('Unable to create Location.')
        end
      end

      context 'for guest user' do
        it 'returns error' do
          post '/api/locations', params: valid_attributes
          expect(json['error']).to be_truthy
        end
      end
    end
  end
end
