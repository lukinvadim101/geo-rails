# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: 'logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'sessions',
                       registrations: 'registrations'
                     },
                     defaults: { format: :json }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'locations#index'
  get 'save', to: 'locations#save'
  # delete 'logout', to: 'devise/sessions#destroy'
  resources :locations, only: %i[show create update destroy index]
end
