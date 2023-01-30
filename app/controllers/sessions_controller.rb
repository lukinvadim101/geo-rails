# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  private

  def respond_with(_resource, _options = {})
    if _resource.errors.empty? & resource.id?
      json_response data: {
        message: 'User signed in successfully',
        email: resource.email,
        token: request.env['warden-jwt_auth.token']
      }
    else
      json_response({ error: resource.errors }, status: :unprocessable_entity)
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
