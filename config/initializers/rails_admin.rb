# frozen_string_literal: true

RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ## == Devise ==q
  config.authenticate_with do
    render json: { "error": 'No permissions for admin panel' } unless current_user.try(:admin?)
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit
    delete
  end
end
