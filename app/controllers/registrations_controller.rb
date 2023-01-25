class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # def create
  #   @user = User.new(sign_up_params)
  #   if @user.save
  #     render json: @user
  #   else
  #     render json: { errors: @user.errors }
  #   end
  # end

  # def sign_up_params
  #   params.permit(:email, :password, :password_confirmation)
  # end

  private

  def respond_with(resource, _options = {})
    # ActiveRecord::RecordNotUnique (PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_users_on_email"
    # ActiveRecord::RecordNotUnique (PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint "index_users_on_email"

    if resource.persisted?

      json_response data: {
        message: 'Signed up successfully',
        email: resource.email
      }
    else
      render json: {
        data: { message: 'User could not be created',
                errors: resource.errors.full_messages }, status: :unprocessable_entity
      }
    end
  end
end
