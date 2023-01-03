Rails.application.routes.draw do
  Rails.application.routes.draw do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    get 'home/index'
    root 'home#index'
  end
end
