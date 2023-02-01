# frozen_string_literal: true

Rails.application.routes.draw do
  # devise_for :users, path: 'api/users',
  #   defaults: { format: :json },
  #   controllers: { sessions: 'api/users/sessions', registrations: 'api/users/registrations'},
  #   skip: :all

  namespace :api do
    devise_scope :user do
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      post   '/signup', to: 'registrations#create'
    end
  end

  scope :api, defaults: { format: :json } do
    devise_for :users, path: 'api/users',
                       controllers: { sessions: 'api/sessions', registrations: 'api/registrations' },
                       skip: :all
  end

  mount RailsAdmin::Engine => 'api/admin', as: 'rails_admin'

  root 'api/locations#index'

  get 'api/save', to: 'api/locations#save'

  namespace :api, defaults: { format: :json } do
    resources :locations, only: %i[show create update destroy index]
  end
end
