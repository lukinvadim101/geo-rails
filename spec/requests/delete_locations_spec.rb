# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Api::LocationsController, type: :request do
  describe 'when authenticated user' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:user) }
    let!(:location) { FactoryBot.create(:location, user_id: user.id) }
    let!(:second_user_location) { FactoryBot.create(:location, user_id: second_user.id) }

    describe 'DELETE destroy' do
      context 'for locations owner' do
        before do
          login_as(user)
          delete "/api/locations/#{second_user_location.id}"
        end

        it 'returns unsuccessful response status' do
          expect(response.status).to eq 422
        end

        it 'record still exist' do
          expect(Location.exists?(second_user_location.id)).to be true
        end
      end
    end

    context 'for self locations' do
      before do
        login_as(user)
        delete "/api/locations/#{location.id}"
      end

      it 'returns successful response status' do
        expect(response.status).to eq 200
      end

      it 'record still deleted' do
        expect(Location.exists?(location.id)).to be false
      end
    end

    context 'for guest user' do
      it 'returns error' do
        delete "/api/locations/#{location.id}"
        expect(json['error']).to be_truthy
      end
    end
  end
end
