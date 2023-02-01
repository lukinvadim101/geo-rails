# frozen_string_literal: true

require 'rails_helper'
describe Api::SessionsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:login_url) { '/api/login' }
  let(:logout_url) { '/api/logout' }

  describe 'logging in / POST create' do
    context 'valid password' do
      # before do
      #   post login_url, params: { user: { email: user.email, password: user.password } }
      # end

      it 'returns 200' do
        post login_url, params: { user: { email: user.email, password: user.password } }
        expect(json['data']['message']).to eq('User signed in successfully')
        expect(response.status).to eq(200)
      end

      it 'returns a token' do
        post login_url, params: { user: { email: user.email, password: user.password } }
        expect(response.headers['Authorization']).to be_present
      end

      it 'returns a token value' do
        post login_url, params: { user: { email: user.email, password: user.password } }
        expect(json['data']['token']).to be_present
      end
    end

    context 'when missing password' do
      before do
        post login_url, params: { user: { email: user.email, password: nil } }
      end

      it 'returns 401' do
        expect(response.status).to eq(401)
      end

      it 'not settle user_id in session' do
        expect(response.body).to eq('Invalid Email or password.')
      end
    end
  end

  describe 'logging out / DELETE destroy' do
    it 'returns 204' do
      delete logout_url

      expect(response).to have_http_status(:no_content)
    end
  end
end
