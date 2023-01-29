require 'rails_helper'
include Devise::Test::IntegrationHelpers

describe RegistrationsController, type: :request do
  let(:user) { FactoryBot.build(:user) }
  let(:existing_user) { FactoryBot.create(:user) }
  let(:signup_url) { '/signup' }

  context 'when creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user email' do
      expect(json['data']['email']).to eq(user.email)
    end
  end

  context 'when email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns User could not be created' do
      expect(json['data']['message']).to eq('User could not be created')
    end
  end
end
