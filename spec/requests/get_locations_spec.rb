# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Api::LocationsController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:user) }
  let!(:location) { FactoryBot.create(:location, user_id: user.id) }
  let(:second_user_location) { FactoryBot.create(:location, user_id: second_user.id) }

  describe 'when authenticated user' do
    context 'for location owner' do
      describe 'GET /locations' do
        it 'return success ststus' do
          login_as(user)
          get '/api/locations'
          expect(response.status).to be 200
        end

        it 'render user locations' do
          login_as(user)
          get '/api/locations'

          expect(json['data'].count).to eq(1)
          expect(json['data'][0]['type']).to eq('locations')
          expect(json['data'][0]['attributes']['latitude']).to eq(location.latitude)
        end

        describe 'GET /locations/:id' do
          it 'render users locations' do
            login_as(user)
            get "/api/locations/#{location.id}"
            expect(json['data']['attributes']['user-id']).to be user.id
          end
        end
      end
    end

    context 'when not a location owner' do
      before do
        login_as(second_user)
        get "/api/locations/#{location.id}"
      end

      it 'do not render other user locations' do
        expect(json['error']).to eq('You are not authorized to access this page.')
      end
    end

    context 'when incorrect location_id' do
      it 'custom RecordNotFound handler correct' do
        login_as(user)
        get '/api/locations/88888888'
        expect(json['error']).to include "Couldn't find Location with"
      end
    end
  end

  context 'for guest user' do
    describe '/locations' do
      it 'returns error' do
        get '/api/locations'
        expect(json['error']).to be_truthy
      end
    end

    describe '/locations/:id' do
      it 'returns error' do
        get "/api/locations/#{location.id}"
        expect(json['error']).to be_truthy
      end
    end
  end
end
