require 'rails_helper'

RSpec.describe 'DELETE locations/:id', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }
  let(:location) { FactoryBot.create(:location, user_id: admin.id) }
  let(:valid_attributes) { { location: location } }
  describe 'destroy' do
    context 'with valid parameters' do
      before do

        login_as(admin)
        # delete "#{locations_path}/#{location.id}"
        delete "#{locations_path}/#{location.id}"
      end

      it 'status ok' do
        expect(response.status).to be 200
      end

      it 'not ok' do
        expect(Location.exists?(location.id)).to be false
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
