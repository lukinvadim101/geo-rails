# frozen_string_literal: true

require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!
require 'devise/jwt/test_helpers'

RSpec.describe Api::LocationsController, type: :request do
  describe 'when authenticated user' do
    let(:user) { FactoryBot.create(:user) }

    describe 'GET checkin' do
      context 'with valid parameters' do
        before do
          login_as(user)
          get '/api/checkin'
        end

        it 'returns correct attribute' do
          expect(json['data']['attributes']['user-id']).to eq(user.id)
        end

        it 'returns status ok' do
          expect(response).to have_http_status('200')
        end
      end

      context 'for guest user' do
        it 'returns error' do
          get '/api/checkin'
          expect(json['error']).to be_truthy
        end
      end
    end
  end
end
