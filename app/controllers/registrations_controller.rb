class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    # ActiveRecord::RecordNotUnique (PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_users_on_email"
    # ActiveRecord::RecordNotUnique (PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_users_on_email"
    # Warden::JWTAuth::UserEncoder.new.call(@user, :user, "JWT_AUD")

    if resource.persisted?
      render json: {
        data: { code: 200, message: 'Signed up successfully',
                email: resource.email,
                token: "Bearer #{Warden::JWTAuth::UserEncoder.new.call(@user, :user, 'JWT_AUD')}" }
      }, status: :ok
    else
      render json: {
        data: { message: 'User could not be created',
                errors: resource.errors.full_messages }, status: :unprocessable_entity
      }
    end
  end
end
