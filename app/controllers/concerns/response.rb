# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def jsonapi_response(resource)
    if resource.errors.empty?
      json_response resource
    else
      json_response resource.errors
    end
  end
end
