# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  before_action :set_default_format
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  private

  def set_default_format
    request.format = :json
  end
end
