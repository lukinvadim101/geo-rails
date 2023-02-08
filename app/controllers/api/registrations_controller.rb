# frozen_string_literal: true

module Api
  class RegistrationsController < Devise::RegistrationsController
    include Response
    def create
      build_resource(sign_up_params)
      resource.save
      sign_up(resource_name, resource)

      if resource.persisted?
        json_response data: { message: 'Signed up successfully',
                              email: resource.email }
      else
        json_response data: { message: 'User could not be created',
                              errors: resource.errors.full_messages },
                      status: :unprocessable_entity
      end
    end
  end
end
