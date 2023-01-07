# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET Locations', type: :request do
  let(:first_user) { FactoryBot.create(:user) }
  let(:second_user) { FactoryBot.create(:user) }
  let(:first_user_location) { FactoryBot.create(:location, user_id: first_user.id) }

  context 'unauthorized user' do
    describe '/locations' do
      it 'redirect' do
        get '/locations'
        expect(response.body).to include('redirected')
      end
    end

    describe '/locations/:id' do
      it 'redirect' do
        get "/locations/#{first_user_location.id}"
        expect(response.body).to include('redirected')
      end
    end
  end

  context 'authorized user' do
    describe '/locations' do
      it 'success' do
        login_as(first_user)
        get '/locations'
        expect(response.status).to be 200
      end
    end

    describe '/locations/:id' do
      it 'render users locations' do
        login_as(first_user)
        get "/locations/#{first_user_location.id}"
        expect(json.first['user_id']).to be first_user.id
      end

      it 'do not render other user locations' do
        login_as(second_user)
        get "/locations/#{first_user_location.id}"
        expect(json['message']).to eq('no location found')
      end
    end
  end
end
