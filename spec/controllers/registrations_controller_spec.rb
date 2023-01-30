require 'rails_helper'

describe RegistrationsController, type: :request do
  let(:user) { FactoryBot.build(:user) }
  let(:existing_user) { FactoryBot.create(:user) }
  let(:signup_url) { '/signup' }

  describe 'creating a new user / POST create' do
    context 'with unique email' do
      it 'returns 200' do
        post signup_url, params: { user: { email: user.email, password: user.password } }
        expect(response.status).to eq(200)
      end

      it 'returns the user email' do
        post signup_url, params: { user: { email: user.email, password: user.password } }
        expect(json['data']['email']).to eq(user.email)
      end
    end

    context 'when email already exists' do
      it 'returns User could not be created' do
        post signup_url,
             params: { user: { email: existing_user.email, password: existing_user.password } }
        expect(json['data']['message']).to eq('User could not be created')
      end
    end
  end
end
