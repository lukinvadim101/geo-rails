# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActionDispatch::Http::Parameters::ParseError do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      json_response({ message: 'user already exists' }, :unprocessable_entity)
    end

    rescue_from CanCan::AccessDenied do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
