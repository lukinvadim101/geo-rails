Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://your.frontend.domain.com'
    resource '*',
             headers: %w[Authorization],
             methods: :any,
             expose: %w[Authorization]
  end
end
