# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound,
                ActiveRecord::RecordInvalid,
                ActiveRecord::RecordNotUnique,
                ActionController::ParameterMissing,
                ActionDispatch::Http::Parameters::ParseError,
                CanCan::AccessDenied,
                JWT::ExpiredSignature,
                JWT::VerificationError,
                JWT::DecodeError do |e|
      json_response({ error: e.message }, :unprocessable_entity)
    end
  end

  class MyApplicationFailureApp < Devise::FailureApp
    def http_auth_body
      return super unless request_format == :json

      {
        sucess: false,
        message: i18n_message
      }.to_json
    end
  end
end
