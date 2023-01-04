# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  resources :locations, only: %i[show new create update index pri]
  get 'locations/public' => 'locations#public', as: 'public_locations'
end
