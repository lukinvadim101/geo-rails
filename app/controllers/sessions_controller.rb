# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _options = {})
    return if resource.id.blank?

    # binding.pry
    # return unless user_signed_in?

    render json: {
      message: 'User signed in successfully',
      # data: current_user,
      # token: Warden::JWTAuth::UserEncoder.new.call(@user, :user, 'JWT_AUD')
      token: request.env['warden-jwt_auth.token']
    }, status: :ok
  end

  # def valid?
  #   request.headers['Authorization'].present?
  # end

  def respond_to_on_destroy
    return if request.headers['Authorization'].blank?

    begin
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'),
                               Rails.application.secrets.secret_key_base).first
      # binding.pry
      current_user = User.find(jwt_payload['id'])
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
      head :unauthorized
    end
  end

  # jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
  #                          Rails.application.credentials.devise[:jwt_secret_key]).first
  # current_user = User.find(jwt_payload['sub'])
  # if current_user
  #   render json: {
  #     status: 200,
  #     message: 'Signed out successfully'
  #   }, status: :ok
  # else
  #   render json: {
  #     status: 401,
  #     message: 'User has no active session'
  #   }, status: :unauthorized
  # end
  # end
end
