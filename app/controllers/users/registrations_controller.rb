# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      register_success && return if resource.persisted?

      register_failed
    end

    def register_success
      render json: { message: 'Signed up successfully.' }
    end

    def register_failed
      render json: { message: 'Something went wrong.' }
    end

    def new
      render json: { message: 'Sodsdsd.' }
    end
  end
end
