# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  include Response
  include ExceptionHandler
end
