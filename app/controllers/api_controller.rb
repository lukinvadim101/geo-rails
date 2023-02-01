# frozen_string_literal: true

class ApiController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_user!

  include ActionController::MimeResponds
  respond_to :json

  include Response
  include ExceptionHandler

  private

  def set_default_format
    request.format = :json
  end
end
