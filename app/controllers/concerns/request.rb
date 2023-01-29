module Request
  def valid?
    request.headers['Authorization'].present?
  end

  def decode_user_id(request)
    return unless valid?

    JWT.decode(request.headers['Authorization'].split(' ')[1].remove('"'),
               Rails.application.credentials.devise[:jwt_secret_key]).first['sub']
    # rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    #   json_response message: 'Token Decode error'
  end
end
