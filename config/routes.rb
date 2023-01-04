# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  resources :locations, only: %i[show new create update index]
  get 'locations/public'  => 'locations#public_locations',  as: 'public_locations'
  get 'locations/private' => 'locations#private_locations', as: 'private_locations'
end
