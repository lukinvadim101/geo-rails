# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'locations#index'
  get 'autosave', to: 'locations#autosave'
  resources :locations, only: %i[show create update destroy index]
end
