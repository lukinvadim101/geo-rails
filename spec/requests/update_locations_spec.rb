# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /locations/:id', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:location) { FactoryBot.create(:location, user_id: user.id) }
  let(:valid_attributes) { { location: { name: 'totally different name' } } }
  let(:invalid_attributes) { { hack: {} } }


  describe 'update' do
    context 'with valid parameters' do
      before do
        login_as(user)
        put "/locations/#{location.id}", params: valid_attributes
      end

      it 'got success message' do
        expect(json['message']).to eq('location successfully update.')
      end

      it 'returns a updated status' do
        expect(response).to have_http_status(:ok)
      end

      it 'parameter was updated' do
        # change to location.reload
        get "/locations/#{location.id}"
        expect(json['name']).to eq('totally different name')
      end
    end
  end
end
