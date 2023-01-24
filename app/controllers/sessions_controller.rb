# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  # def create
  #   super do |resource|
  #     resource.token =
  #   end
  # end

  private

  def respond_with(_resource, _options = {})
    return if resource.id.blank?

    # return unless user_signed_in?
    render json: {
      message: 'User signed in successfully',
      data: current_user,
      token: "Bearer #{@user.generate_jwt}"
    }, status: :ok
  end

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
