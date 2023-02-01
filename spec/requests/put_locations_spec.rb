# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Api::LocationsController, type: :request do
  describe 'when authenticated user' do
    let(:user) { FactoryBot.create(:user) }
    let(:second_user) { FactoryBot.create(:user) }
    let(:location) { FactoryBot.create(:location, user_id: user.id) }
    let(:second_user_location) { FactoryBot.create(:location, user_id: second_user.id) }
    let(:valid_attributes) { attributes_for(:location) }

    before do
      login_as(user)
    end

    describe 'PUT update' do
      context 'with valid parameters' do
        before do
          put "/api/locations/#{location.id}",
              params: { location: { name: 'totally different name' } }
        end

        it 'got success message' do
          expect(json['message']).to eq('location successfully update.')
        end

        it 'returns status ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'parameter was updated' do
          expect(Location.find(location.id).name).to eq('totally different name')
        end
      end

      context 'with invalid parameters' do
        before do
          put "/api/locations/#{location.id}",
              params: { location: { name: nil, latitude: '123321' } }
        end

        it "doesn't update parameter in database" do
          expect(location.latitude).not_to eq('123321')
        end
      end

      context 'can not update other user locations' do
        before do
          put "/api/locations/#{second_user_location.id}",
              params: { location: { name: 'totally different name' } }
        end

        it 'returns unsuccessful response status' do
          expect(response.status).to eq 422
        end

        it 'record attributes not changed' do
          expect(second_user_location.name).not_to eq('totally different name')
        end
      end

      context 'for guest user' do
        it 'returns error' do
          put "/api/locations/#{location.id}", params: valid_attributes
          expect(json['error']).to be_truthy
        end
      end
    end
  end
end
