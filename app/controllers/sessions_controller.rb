# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _options = {})
    return unless user_signed_in?

    json_response data: {
      message: 'User signed in successfully',
      email: current_user.email,
      token: request.env['warden-jwt_auth.token']
    }, status: :ok
  end

  def respond_to_on_destroy
    return if request.headers['Authorization'].blank?

    binding.pry
    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'),
                               Rails.application.secrets.secret_key_base).first
      # binding.pry
      current_user = User.find(jwt_payload['sub'])
      if current_user
        render json: {
          status: 200,
          message: 'Signed out successfully'
        }, status: :ok
      else
        render json: {
          status: 401,
          message: 'User has no active session'
        }, status: :unauthorized
      end
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      # json_response {"dsd":"www"}
    end
  end
end
