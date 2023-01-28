module Request
  def valid?
    request.headers['Authorization'].present?
  end
end
