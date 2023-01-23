# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

describe 'DELETE destroy' do
  let(:user) { FactoryBot.create(:user) }

  it 'tests logout' do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    # request.headers.merge!(auth_headers)

    # delete '/logout', headers: auth_headers, params: { id: user.id }
    delete '/logout', headers: auth_headers, params: { id: user.id }
    # binding.pry
    expect(json['message']).to eq('Signed out successfully')
  end

  #   it 'response with json success' do
  #
  #     # post '/login', params: { user :{ email} }
  #     # binding.pry
  #     expect(response.body['message']).to have_content('Signed out successfully')
  #   end
  #
  #   it 'deletes current_user' do
  #     delete :destroy, params: { id: user.id }
  #     expect(controller.current_user.exists?(user.id)).to be_falsy
  #   end
end
