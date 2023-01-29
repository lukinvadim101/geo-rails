# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  private

  def respond_with(_resource, _options = {})
    if _resource.errors.empty?
      json_response data: {
        message: 'User signed in successfully',
        email: resource.email,
        token: request.env['warden-jwt_auth.token']
      }
    else
      json_response resource.errors, status: :bad_request
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
