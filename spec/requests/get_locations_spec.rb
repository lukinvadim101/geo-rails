# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:location1) { FactoryBot.create(:location, user_id: user1.id) }

  context 'unauthorized user' do
    describe 'GET /locations' do
      it 'redirect' do
        get '/locations'
        expect(response.body).to include('redirected')
      end
    end

    describe 'GET /locations/:id' do
      it 'redirect' do
        get "/locations/#{location1.id}"
        expect(response.body).to include('redirected')
      end
    end
  end

  context 'authorized user' do
    describe 'GET /locations' do
      it 'success' do
        login_as(user1)
        get '/locations'
        expect(response.status).to be 200
      end
    end

    describe 'GET /locations/:id' do
      it 'render user locations' do
        login_as(user1)
        get "/locations/#{location1.id}"
        expect(json['location'].first['user_id']).to be user1.id
      end

      it 'do not render other user locations' do
        login_as(user2)
        get "/locations/#{location1.id}"
        expect(json['message']).to eq('no location found')
      end
    end
  end
end
