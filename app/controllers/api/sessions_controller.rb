# frozen_string_literal: true

class Api::SessionsController < Devise::SessionsController
  private

  def respond_with(resource, _options = {})
    if resource.errors.empty?
      render json: { data: {
        message: 'User signed in successfully',
        email: resource.email,
        token: request.env['warden-jwt_auth.token']
      } }, status: :ok
    else
      render json: { error: resource.errors }
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
