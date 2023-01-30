# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /admin ', type: :request do
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:user) { FactoryBot.create(:user) }

  context 'with admin credentials' do
    before do
      login_as(admin_user)
    end

    it 'status ok' do
      get '/admin'
      expect(response.status).to eq(200)
    end
  end

  context 'with regular user credentials' do
    before do
      login_as(user)
    end

    it 'render json error' do
      get '/admin'
      expect(json['error']).to eq('No permissions for admin panel')
    end
  end

  context 'with no user credentials' do
    it 'render json error' do
      get '/admin'
      expect(json['error']).to eq('No permissions for admin panel')
    end
  end
end

# describe "DELETE destroy" do
#   before do
#     delete "#{locations_path}/#{user_location.id}"
#   end
#
#   it 'returns status ok' do
#     expect(response.status).to be 200
#   end
#
#   it 'record destroys' do
#     expect(Location.exists?(user_location.id)).to be false
#   end
# end
