module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _options = {})
      if resource.persisted?
        render json: {
          data: { code: 200, message: 'Signed up successfully', data: resource }
        }, status: :ok
      else
        render json: {
          data: { message: 'User could not be created',
                  errors: resource.errors.full_messages }, status: :unprocessable_entity
        }
      end
    end
  end
end
