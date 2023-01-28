# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
                                 sign_in: 'login',
                                 sign_out: '/logout',
                                 registration: 'signup'
                               },
                     controllers: {
                       sessions: 'sessions',
                       registrations: 'registrations'
                     },
                     defaults: { format: :json }

  # to do custom devise
  # ,
  #                    skip: %i[sessions registrations]

  # devise_scope :user do
  #   post 'login', to: 'devise/sessions#create', as: :user_session
  #   delete '/users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'locations#index'
  get 'save', to: 'locations#save'
  # delete 'logout', to: 'devise/sessions#destroy'
  resources :locations, only: %i[show create update destroy index]
end
