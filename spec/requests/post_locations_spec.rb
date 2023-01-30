# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :request do
  describe 'when authenticated user' do
    let(:user) { FactoryBot.create(:user) }
    let(:second_user) { FactoryBot.create(:user) }
    let(:user_location) { FactoryBot.create(:location, user_id: user.id) }
    let(:second_user_location) { FactoryBot.create(:location, user_id: second_user.id) }

    before do
      login_as(user)
    end

    describe 'POST create' do
      let(:location) { FactoryBot.build(:location) }
      let(:valid_attributes) do
        {
          location: { name: location.name,
                      user_id: user.id,
                      latitude: location.latitude,
                      longitude: location.longitude }
        }
      end

      context 'with valid parameters' do
        before do
          post '/locations', params: valid_attributes
        end

        it 'returns correct attribute' do
          expect(json['name']).to eq(location.name)
        end

        it 'returns a created status' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        it 'returns error message' do
          post '/locations', params: {
            location: { name: nil,
                        latitude: 9999 }
          }
          expect(json['error']).to include('Validation failed')
        end
      end
    end

    describe 'PUT update' do
      let!(:location) { FactoryBot.create(:location, user_id: user.id) }
      let(:valid_attributes) { { location: { name: 'totally different name' } } }

      context 'with valid parameters' do
        it 'got success message' do
          put "/locations/#{location.id}", params: valid_attributes
          expect(json['message']).to eq('location successfully update.')
        end

        it 'returns a updated status' do
          put "/locations/#{location.id}", params: valid_attributes
          expect(response).to have_http_status(:ok)
        end

        it 'parameter was updated' do
          put "/locations/#{location.id}", params: valid_attributes
          location.reload
          expect(Location.exists?(location.id)).to be true
        end
      end

      ###### TO DO
      context 'with invalid parameters' do
        let(:invalid_attributes) { { location: { name: '' } } }

        # it 'renders :edit template' do
        #   put "/locations/#{location.id}", params: invalid_attributes
        #   expect(response).to have_http_status(:unauthorized)
        # end

        # it "doesn't updates parameter in database" do
        #   put "/locations/#{location.id}", params: invalid_attributes
        #   location.reload
        #   expect(Location.exists?(location.id)).to be false
        # end
      end
    end

    describe 'GET locations' do
      it 'success' do
        get '/locations'
        expect(response.status).to be 200
      end
    end

    describe 'GET /locations/:id' do
      it 'render users locations' do
        get "/locations/#{user_location.id}"
        expect(json['user_id']).to be user.id
      end

      it 'do not render other user locations' do
        login_as(second_user)
        get "/locations/#{user_location.id}"
        expect(json['error']).to eq('You are not authorized to access this page.')
      end

      it 'custom RecordNotFound handler correct' do
        get '/locations/88888888'
        expect(json['error']).to include "Couldn't find Location with"
      end
    end

    describe 'DELETE destroy' do
      describe 'can not destroy other user locations' do
        before do
          delete "locations/#{second_user_location.id}"
        end

        it 'returns unsuccessful response status' do
          expect(response.status).to eq 422
        end

        it 'record still exist' do
          expect(Location.exists?(second_user_location.id)).to be true
        end
      end

      describe 'can destroy self locations' do
        before do
          delete "locations/#{user_location.id}"
        end

        it 'returns unsuccessful response status' do
          expect(response.status).to eq 200
        end

        it 'record still exist' do
          expect(Location.exists?(user_location.id)).to be false
        end
      end
    end
  end
end

describe 'guest user' do
  let(:user) { FactoryBot.create(:user) }
  let(:user_location) { FactoryBot.create(:location, user_id: user.id) }

  describe 'GET locations'
  describe '/locations' do
    it 'get error' do
      get '/locations'
      expect(json['error']).to be_truthy
    end
  end

  describe '/locations/:id' do
    it 'get error' do
      get "/locations/#{user_location.id}"
      expect(json['error']).to be_truthy
    end
  end
end

# describe 'admin user' do
#   let(:admin_user) { FactoryBot.create(:user, admin: true) }
#
#   describe 'GET /admin ' do
#     let(:user) { FactoryBot.create(:user) }
#
#     context 'when autorized' do
#       it 'redirect' do
#         get '/admin'
#         expect(response.body).to include('redirected')
#       end
#     end
#
#     ###### TO DO
#   end

# describe 'admin user' do
#   let(:admin) { FactoryBot.create(:user, admin: true) }
#   let(:admin_location) { FactoryBot.create(:location, user_id: admin.id) }
#
#   describe 'GET /admin ' do
#     let(:user) { FactoryBot.create(:user) }
#
#     context 'when autorized' do
#       it 'redirect' do
#         get '/admin'
#         expect(response.body).to include('redirected')
#       end
#     end
#
#   ###### TO DO
# end
#
# describe "DELETE destroy" do
#   before do
#       delete "#{locations_path}/#{user_location.id}"
#     end
#
#     it 'returns status ok' do
#       expect(response.status).to be 200
#     end
#
#     it 'record destroys' do
#       expect(Location.exists?(user_location.id)).to be false
#     end
#   end
#
#   describe '/admin panel access' do
#     it 'have access' do
#       login_as(admin_user)
#       get '/admin'
#       expect(response.status).to be 200
#     end
#   end
# end

#
#   describe '/admin panel access' do
#     it 'have access' do
#       login_as(admin_user)
#       get '/admin'
#       expect(response.status).to be 200
#     end
#   end
# end
