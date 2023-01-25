# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://geo-gde-to.herokuapp.com/'
    resource '*',
             headers: %w[Authorization],
             methods: %i[get post put patch delete options head],
             expose: %w[Authorization]
  end
end
