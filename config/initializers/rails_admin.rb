RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ## == Devise ==
  config.authenticate_with do
    redirect_to '/', notice: 'Got no permissions to admin panel access' unless warden.user.admin?
  end
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    bulk_delete
    show
    edit
    delete
  end
end
