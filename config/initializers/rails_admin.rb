RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ## == Devise ==
  config.authenticate_with do
    redirect_to '/', alert: 'No permissions for admin panel' unless warden.user.admin?
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
