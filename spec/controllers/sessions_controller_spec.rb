# frozen_string_literal: true

require 'rails_helper'

describe SessionsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:login_url) { '/login' }
  let(:logout_url) { '/logout' }

  context 'when logging in' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns a token value' do
      expect(json['data']['token']).to be_present
    end
  end

  context 'when password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  context 'when logging out' do
    it 'returns 204' do
      delete logout_url

      expect(response).to have_http_status(:no_content)
    end
  end
end

# describe SessionsController, type: :request do
#   let(:user) { FactoryBot.create(:user) }
#
#   describe 'Login' do
#     context 'valid password' do
#       before do
#         sign_in user
#       end
#
#       it 'login user' do
#         expect(response.status).to eq 200
#       end
#
#       it 'set user_id in session' do
#         expect(session['warden.user.user.key'].first.first).to eq(user.id)
#       end
#
#       # expect(response).to have_http_status(:ok)
#       # json = JSON.parse(response.body)
#
#       # expect(json['data'].count).to eq(2)
#       # expect(json['data'][0]['type']).to eq('meals')
#       # expect(json['data'][0]['attributes']['title']).to eq('la ensalsda Mexicana')
#     end
#
#     context 'invalid password' do
#       it 'redirects to login page' do
#         post '/login', params: { session: { email: user.email, password: 'wrong' } }
#
#         expect(response).to render_template(:new)
#         expect(flash[:alert]).to be_truthy
#       end
#
#       it 'not settle user_id in session' do
#         post :create, params: { session: { email: user.email, password: 'wrong' } }
#         expect(session[:user_id]).to be_falsy
#       end
#     end
#   end
#
#   # describe 'DELETE destroy' do
#   #   before do
#   #     user&.authenticate('password123')
#   #     request.session[:user_id] = user.id
#   #   end
#   #
#   #   it 'redirects to login page' do
#   #     delete :destroy, params: { id: user.id }
#   #     expect(response).to redirect_to(root_path)
#   #   end
#   #
#   #   it 'deletes user_id from session' do
#   #     delete :destroy, params: { id: user.id }
#   #     expect(session[:user_id]).to be_falsy
#   #   end
#   # end
# end
