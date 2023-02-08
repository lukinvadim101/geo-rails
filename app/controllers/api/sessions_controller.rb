# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    include Response

    private

    def respond_with(resource, _options = {})
      if resource.errors.empty?
        json_response data: {
          message: 'User signed in successfully',
          email: resource.email,
          token: request.env['warden-jwt_auth.token']
        }
      else
        json_response error: resource.errors
      end
    end

    def respond_to_on_destroy
      head :no_content
    end
  end
end
