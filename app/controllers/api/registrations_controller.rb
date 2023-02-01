# frozen_string_literal: true

class Api::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource)

    if resource.persisted?
      render json: { data: { message: 'Signed up successfully',
                             email: resource.email } }
    else
      render json: { data: {  message: 'User could not be created',
                              errors: resource.errors.full_messages },
                     status: :unprocessable_entity }
    end
  end
end
