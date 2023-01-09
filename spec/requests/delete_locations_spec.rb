# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE locations/:id', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }
  let(:admin_location) { FactoryBot.create(:location, user_id: admin.id) }
  let(:user_location) { FactoryBot.create(:location, user_id: user.id) }

  context 'admin' do
    before do
      login_as(admin)
      delete "#{locations_path}/#{user_location.id}"
    end

    it 'returns status ok' do
      expect(response.status).to be 200
    end

    it 'record destroys' do
      expect(Location.exists?(user_location.id)).to be false
    end
  end

  context 'user' do
    describe 'can not destroy other user locations' do
      before do
        login_as(user)
        delete "#{locations_path}/#{admin_location.id}"
      end

      it 'returns unsuccessful response status' do
        expect(response.status).to eq 422
      end

      it 'record still exist' do
        expect(Location.exists?(admin_location.id)).to be true
      end
    end

    describe 'can destroy self locations' do
      before do
        login_as(user)
        delete "#{locations_path}/#{user_location.id}"
      end

      it 'returns unsuccessful response status' do
        expect(response.status).to eq 200
      end

      it 'record still exist' do
        expect(Location.exists?(user_location.id)).to be false
      end
    end
  end

  # describe 'destroy' do
  #   before do
  #     # binding.pry
  #     login_as(user)
  #     delete "/locations/#{location.id}"
  #
  #   end
  #
  #   it 'not ok' do
  #     expect(Location.exists?(location.id)).to be false
  #   end
  # end
end
